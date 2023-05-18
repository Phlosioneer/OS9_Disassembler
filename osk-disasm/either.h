#ifndef MONADS_H
#define MONADS_H

#include "pch.h"

#include <utility> // For std::forward and std::move

// Based on https://codereview.stackexchange.com/a/252957

struct left_tag_t
{
};
struct right_tag_t
{
};

// Thrown when the wrong side of an Either is accessed.
class no_value_error : public std::runtime_error
{
  public:
    inline no_value_error(const std::string& message) : std::runtime_error(message)
    {
    }
    inline no_value_error(const char* message) : std::runtime_error(message)
    {
    }
    virtual ~no_value_error() = default;
};

// Thrown when accessing an Either while it's empty.
class empty_value_error : public std::runtime_error
{
  public:
    inline empty_value_error()
        : std::runtime_error(
              "Either object is empty due to an exception while constructing a type during an assignment operation.")
    {
    }
    virtual ~empty_value_error() = default;
};

template <class Left, class Right>
class Either
{
  private:
    enum class State
    {
        HasLeft,
        HasRight,
        EmptyBecauseOfExcept
    };
    static inline void invalidState(State state)
    {
        throw std::runtime_error("Invalid State enum value");
    }

  public:
    // In-place constructors
    template <class... U>
    Either(left_tag_t, U&&... args) : _state(State::HasLeft), _left(std::forward<U>(args)...)
    {
    }
    template <class... U>
    Either(right_tag_t, U&&... args) : _state(State::HasRight), _right(std::forward<U>(args)...)
    {
    }

    // Type constructors
    Either(Left x) : Either(left_tag_t(), std::move(x))
    {
    }
    Either(Right x) : Either(right_tag_t(), std::move(x))
    {
    }

    // Copy constructor
    Either(const Either& other) : _state(other._state)
    {
        // Use placement new to initialize union members.
        switch (_state)
        {
        case State::HasLeft:
            new (&_left) Left(other._left);
            break;
        case State::HasRight:
            new (&_right) Right(other._right);
            break;
        case State::EmptyBecauseOfExcept:
            _empty = other._empty;
            break;
        default:
            invalidState(_state);
        }
    }

    // Move constructor
    Either(Either&& other) : _state(other._state)
    {
        // Use placement new to initialize union members.
        switch (_state)
        {
        case State::HasLeft:
            new (&_left) Left(std::move(other._left));
            break;
        case State::HasRight:
            new (&_right) Right(std::move(other._right));
            break;
        case State::EmptyBecauseOfExcept:
            _empty = other._empty;
            break;
        default:
            invalidState(_state);
        }
    }

    // Assign operator, which can use the Move constructor for new values.
    Either& operator=(Either& other)
    {
        if (_state == other._state)
        {
            // Use assign-from-const operator.
            switch (_state)
            {
            case State::HasLeft:
                _left = other._left;
                break;
            case State::HasRight:
                _right = other._right;
                break;
            case State::EmptyBecauseOfExcept:
                _empty = other._empty;
                break;
            default:
                invalidState(_state);
            }
        }
        else
        {
            // Explicitly delete the previous value.
            switch (_state)
            {
            case State::HasLeft:
                _left.~Left();
                break;
            case State::HasRight:
                _right.~Right();
                break;
            case State::EmptyBecauseOfExcept:
                break;
            default:
                invalidState(_state);
            }

            // Use placement new with move constructor. On exception, enter "empty" state.
            switch (other._state)
            {
            case State::HasLeft:
                try
                {
                    new (&_left) Left(std::move(other._left));
                    _state = State::HasLeft;
                }
                catch (std::exception)
                {
                    _empty = '\0';
                    _state = State::EmptyBecauseOfExcept;
                    throw;
                }
                break;
            case State::HasRight:
                try
                {
                    new (&_right) Right(std::move(other._right));
                    _state = State::HasRight;
                }
                catch (std::exception)
                {
                    _empty = '\0';
                    _state = State::EmptyBecauseOfExcept;
                    throw;
                }
                break;
            case State::EmptyBecauseOfExcept:
                _empty = other._empty;
                _state = State::EmptyBecauseOfExcept;
                break;
            default:
                invalidState(other._state);
            }
        }

        return *this;
    }

    // Assign-from-const operator, which must use the Copy constructor on new values.
    Either& operator=(const Either& other)
    {
        if (_state == other._state)
        {
            // Use assign-from-const operator.
            switch (_state)
            {
            case State::HasLeft:
                _left = other._left;
                break;
            case State::HasRight:
                _right = other._right;
                break;
            case State::EmptyBecauseOfExcept:
                _empty = other._empty;
                break;
            default:
                invalidState(_state);
            }
        }
        else
        {
            // Explicitly delete the previous value.
            switch (_state)
            {
            case State::HasLeft:
                _left.~Left();
                break;
            case State::HasRight:
                _right.~Right();
                break;
            case State::EmptyBecauseOfExcept:
                break;
            default:
                invalidState(_state);
            }

            // Use placement new with copy constructor. On exception, enter "empty" state.
            switch (other._state)
            {
            case State::HasLeft:
                try
                {
                    new (&_left) Left(other._left);
                    _state = State::HasLeft;
                }
                catch (std::exception)
                {
                    _empty = '\0';
                    _state = State::EmptyBecauseOfExcept;
                    throw;
                }
                break;
            case State::HasRight:
                try
                {
                    new (&_right) Right(other._right);
                    _state = State::HasRight;
                }
                catch (std::exception)
                {
                    _empty = '\0';
                    _state = State::EmptyBecauseOfExcept;
                    throw;
                }
                break;
            case State::EmptyBecauseOfExcept:
                _empty = other._empty;
                _state = State::EmptyBecauseOfExcept;
                break;
            default:
                invalidState(other._state);
            }
        }

        return *this;
    }

    // Destructor
    ~Either()
    {
        switch (_state)
        {
        case State::HasLeft:
            _left.~Left();
            break;
        case State::HasRight:
            _right.~Right();
            break;
        case State::EmptyBecauseOfExcept:
            break;
        default:
            // Silently ignore the error, rather than throw during delete.
            break;
        }
    }

    inline bool isEmptyFromException() const noexcept
    {
        return _state == State::EmptyBecauseOfExcept;
    }

    inline void checkEmptyFromException() const
    {
        if (_state == State::EmptyBecauseOfExcept) throw empty_value_error();
    }

    inline bool hasLeft() const noexcept
    {
        return _state == State::HasLeft;
    }
    Left& left()
    {
        checkEmptyFromException();
        if (_state == State::HasLeft) return _left;
        throw no_value_error("Left value missing");
    }
    const Left& left() const
    {
        checkEmptyFromException();
        if (_state == State::HasLeft) return _left;
        throw no_value_error("Left value missing");
    }
    Left* getIfLeft()
    {
        checkEmptyFromException();
        return _state == State::HasLeft ? &_left : nullptr;
    }
    const Left* getIfLeft() const
    {
        checkEmptyFromException();
        return _state == State::HasLeft ? &_left : nullptr;
    }
    void setLeft(Left left)
    {
        if (_state == State::HasLeft)
        {
            _left = std::move(left);
        }
        else
        {
            if (_state == State::HasRight)
            {
                _right.~Right();
            }

            try
            {
                new (&_left) Left(std::move(left));
                _state = State::HasLeft;
            }
            catch (std::exception)
            {
                _empty = '\0';
                _state = State::EmptyBecauseOfExcept;
                throw;
            }
        }
    }

    inline bool hasRight() noexcept
    {
        return _state == State::HasRight;
    }
    Right& right()
    {
        checkEmptyFromException();
        if (_state == State::HasRight) return _right;
        throw no_value_error("Right value missing");
    }
    const Right& right() const
    {
        checkEmptyFromException();
        if (_state == State::HasRight) return _right;
        throw no_value_error("Right value missing");
    }
    Right* getIfRight()
    {
        checkEmptyFromException();
        return _state == State::HasRight ? &_right : nullptr;
    }
    const Right* getIfRight() const
    {
        checkEmptyFromException();
        return _state == State::HasRight ? &_right : nullptr;
    }
    void setRight(Right right)
    {
        if (_state == State::HasRight)
        {
            _right = right;
        }
        else
        {
            if (_state == State::HasLeft)
            {
                _left.~Left();
            }

            try
            {
                new (&_right) Right(std::move(right));
                _state = State::HasRight;
            }
            catch (std::exception)
            {
                _empty = '\0';
                _state = State::EmptyBecauseOfExcept;
            }
        }
    }

  private:
    State _state;
    union {
        Left _left;
        Right _right;
        char _empty;
    };
};

#endif // MONADS_H
# ********************************************************************* #
# Linux makefile.linux for building dis68                             	#
#                                                                     	#
# ********************************************************************* #
#                                                                     	#
# Copyright (c) 2017 David Breeding                                     #
#                                                                       #
# This file is part of osk-disasm.                                      #
#                                                                       #
# osk-disasm is free software: you can redistribute it and/or modify    #
# it under the terms of the GNU General Public License as published by  #
# the Free Software Foundation, either version 3 of the License, or     #
# (at your option) any later version.                                   #
#                                                                       #
# osk-disasm is distributed in the hope that it will be useful,         #
# but WITHOUT ANY WARRANTY; without even the implied warranty of        #
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         #
# GNU General Public License for more details.                          #
#                                                                       #
# You should have received a copy of the GNU General Public License     #
# (see the file "COPYING") along with osk-disasm.  If not,              #
# see <http://www.gnu.org/licenses/>.                                   #
#                                                               		#
# ********************************************************************* #

#CFLAGS = -m32 -c -g -Wall
LFLAGS = -l=/dd/lib/gclib000.l
CFLAGS  = -V=...
SDIR = ...
ODIR = .
DISRELS = commonsubs.r rof.r dis68.r dismain.r def68def.r opcode00.r lblfuncs.r\
		  opcodes020.r cmdfile.r dprint.r
XTRAS = disglobs.h
PROG  = dis68

$(PROG): $(DISRELS)
	cc $(DISRELS) $(LFLAGS) -f=$(ODIR)/$(PROG)

#$(DISRELS):
#	cc $(CFLAGS) $*.c

# I broke down the dependencies for the object files
# because I couldn't get the above to work...

clean:
	del *.r dis68

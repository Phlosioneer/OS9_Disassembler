/* ************************************************************** *
 * proto_h - Prototypes for functions in dis68                    $
 *                                                                $
 * This file handles both STDC and non-STDC forms                 $
 * $Id::                                                          $
 * ************************************************************** */

#ifndef _HAVEPROTO_
#define _HAVEPROTO_
/* cmdfile.c */
void do_cmd_file(void);
int ApndCmnt(char *lpos);
char *cmntsetup(char *cpos, char *clas, int *adrs);
char *cmdsplit(char *dest, char *src);
void getrange(char *pt, int *lo, int *hi, int usize, int allowopen);
void boundsline(char *mypos);
void setupbounds(char *lpos);
void tellme(char *pt);
/* commonsubs.c */
int get_eff_addr(CMD_ITMS *ci, char *ea, int mode, int reg, int size);
char *pass_eq(char *p);
int strpos(char *s, char c);
char *skipblank(char *p);
int get_extends_common(CMD_ITMS *ci, char *mnem);
int ctl_addrmodesonly(int mode, int reg);
int reg_ea(CMD_ITMS *ci, int j, OPSTRUCTURE *op);
char *regbyte(char *s, unsigned char regmask, char *ad, int doslash);
int revbits(int num, int lgth);
int movem_cmd(CMD_ITMS *ci, int j, OPSTRUCTURE *op);
int link_unlk(CMD_ITMS *ci, int j, OPSTRUCTURE *op);
unsigned int fget_w(FILE *fp);
unsigned int fget_l(FILE *fp);
char fread_b(FILE *fp);
char getnext_b(CMD_ITMS *ci);
int getnext_w(CMD_ITMS *ci);
void ungetnext_w(CMD_ITMS *ci);
short fread_w(FILE *fp);
int fread_l(FILE *fp);
short bufReadW(char **pt);
int bufReadL(char **pt);
void *mem_alloc(int req);
char *freadString(void);
char *lbldup(char *lbl);
/* def68def.c */
OPSTRUCTURE *tablematch(int opword, OPSTRUCTURE *entry);
/* dis68.c */
int main(int argc, char **argv);
FILE *build_path(char *p, char *faccs);
void do_opt(char *c);
void errexit(char *pmpt);
void filereadexit(void);
/* dismain.c */
struct modnam *modnam_find(struct modnam *pt, int desired);
int dopass(int argc, char **argv, int mypass);
int showem(void);
int notimplemented(CMD_ITMS *ci, int tblno, OPSTRUCTURE *op);
void MovBytes(struct databndaries *db);
void MovASC(int nb, char aclass);
void NsrtBnds(struct databndaries *bp);
/* dprint.c */
void tabinit(void);
void PrintAllCodLine(int w1, int w2);
void PrintAllCodL1(int w1);
void PrintPsect(void);
char *get_apcomment(char clas, int addr);
void PrintLine(char *pfmt, CMD_ITMS *ci, char cClass, int cmdlow, int cmdhi);
void printXtraBytes(char *data);
void PrintComment(char lblcClass, int cmdlow, int cmdhi);
void ROFPsect(struct rof_header *rptr);
void WrtEnds(void);
void ParseIRefs(char rClass);
void GetIRefs(void);
int DoAsciiBlock(CMD_ITMS *ci, char *buf, int bufEnd, char iClass);
void ROFDataPrint(void);
char *LoadIData(void);
void OS9DataPrint(void);
void ListData(LBLDEF *me, int upadr, char cClass);
void WrtEquates(int stdflg);
/* lblfuncs.c */
LBLCLAS *labelclass(char lblclass);
void PrintLbl(char *dest, char clas, int adr, LBLDEF *dl, int amod);
struct databndaries *ClasHere(struct databndaries *bp, int adrs);
LBLDEF *findlbl(char lblclass, int lblval);
char *lblstr(char lblclass, int lblval);
LBLDEF *addlbl(char lblclass, int val, char *newname);
void process_label(CMD_ITMS *ci, char lblclass, int addr);
void parsetree(char c);
int LblCalc(char *dst, int adr, int amod, int curloc);
/* opcode00.c */
int biti_reg(CMD_ITMS *ci, int j, OPSTRUCTURE *op);
int biti_size(CMD_ITMS *ci, int j, OPSTRUCTURE *op);
int bit_static(CMD_ITMS *ci, int j, OPSTRUCTURE *op);
int bit_dynamic(CMD_ITMS *ci, int j, OPSTRUCTURE *op);
int move_instr(CMD_ITMS *ci, int j, OPSTRUCTURE *op);
int move_ccr_sr(CMD_ITMS *ci, int j, OPSTRUCTURE *op);
int move_usp(CMD_ITMS *ci, int j, OPSTRUCTURE *op);
int movep(CMD_ITMS *ci, int j, OPSTRUCTURE *op);
int moveq(CMD_ITMS *ci, int j, OPSTRUCTURE *op);
int one_ea(CMD_ITMS *ci, int j, OPSTRUCTURE *op);
int bra_bsr(CMD_ITMS *ci, int j, OPSTRUCTURE *op);
int cmd_no_opcode(CMD_ITMS *ci, int j, OPSTRUCTURE *op);
int bit_rotate_mem(CMD_ITMS *ci, int j, OPSTRUCTURE *op);
int bit_rotate_reg(CMD_ITMS *ci, int j, OPSTRUCTURE *op);
int br_cond(CMD_ITMS *ci, int j, OPSTRUCTURE *op);
int add_sub(CMD_ITMS *ci, int j, OPSTRUCTURE *op);
int cmp_cmpa(CMD_ITMS *ci, int j, OPSTRUCTURE *op);
int addq_subq(CMD_ITMS *ci, int j, OPSTRUCTURE *op);
int abcd_sbcd(CMD_ITMS *ci, int j, OPSTRUCTURE *op);
void addTrapOpt(CMD_ITMS *ci, int ppos);
int trap(CMD_ITMS *ci, int j, OPSTRUCTURE *op);
int cmd_stop(CMD_ITMS *ci, int j, OPSTRUCTURE *op);
int cmd_dbcc(CMD_ITMS *ci, int j, OPSTRUCTURE *op);
int cmd_scc(CMD_ITMS *ci, int j, OPSTRUCTURE *op);
int cmd_exg(CMD_ITMS *ci, int j, OPSTRUCTURE *op);
int ext_extb(CMD_ITMS *ci, int j, OPSTRUCTURE *op);
int cmpm_addx_subx(CMD_ITMS *ci, int j, OPSTRUCTURE *op);
/* opcodes020.c */
int cmp2_chk2(CMD_ITMS *ci, int j, OPSTRUCTURE *op);
int rtm_020(CMD_ITMS *ci, int j, OPSTRUCTURE *op);
int cmd_moves(CMD_ITMS *ci, int j, OPSTRUCTURE *op);
int cmd_cas(CMD_ITMS *ci, int j, OPSTRUCTURE *op);
int cmd_cas2(CMD_ITMS *ci, int j, OPSTRUCTURE *op);
int cmd_callm(CMD_ITMS *ci, int j, OPSTRUCTURE *op);
int muldiv_020(CMD_ITMS *ci, int j, OPSTRUCTURE *op);
int cmd_rtd(CMD_ITMS *ci, int j, OPSTRUCTURE *op);
int cmd_trapcc(CMD_ITMS *ci, int j, OPSTRUCTURE *op);
int bitfields_020(CMD_ITMS *ci, int j, OPSTRUCTURE *op);

#endif   /* #ifndef _HAVEPROTO_*/


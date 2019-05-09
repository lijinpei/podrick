inline void string_set(ptr x, uptr i, uptr c) {
	Sstring_set(x, i, c);
}
#undef Sstring_set

inline void fxvector_set(ptr x, uptr i, uptr n) {
	Sfxvector_set(x, i, n);
}
#undef Sfxvector_set

inline void bytevector_u8_set(ptr x, uptr i, uptr n) {
	Sbytevector_u8_set(x, i, n)
}
#undef Sbytevector_u8_set

inline ptr make_fixnum(uptr x) {
	return Sfixnum(x);
}
#undef Sfixnum

inline ptr make_char(char x) {
	return Schar(x);
}
#undef Schar

inline ptr make_nil() {
	return Snil();
}
#undef Snil

inline ptr make_true() {
	return Strue();
}
#undef Strue

inline ptr make_false() {
	return Sfalse();
}
#undef Sfalse

inline ptr make_boolean(bool x) {
	return Sboolean(x);
}
#undef Sboolean

ptr make_bwp_object() {
	return Sbwp_object;
}
#undef Sbwp_object

ptr make_eof_object() {
	return Seof_object();
}
#undef Seof_object

ptr make_void() {
	return Svoid();
}
#undef Svoid

typedef void(*foreign_callable_entry_point_t)(void);

inline foreign_callable_entry_point_t make_foreigen_callable_entry_point(uptr x) {
	return Sforeign_callable_entry_point(x);
}
#undef Sforeign_callable_entry_point

inline ptr make_foreign_callable_code_object(uptr x) {
	return Sforeign_callable_code_object(x);
}
#undef Sforeign_callable_code_object


#ifdef FEATURE_ICONV
#undef FEATURE_EXPEDITOR
constexpr bool feature_iconv = true;
#else
constexpr bool feature_iconv = false;
#endif
#ifdef FEATURE_EXPEDITOR
#undef FEATURE_EXPEDITOR
constexpr bool feature_expeditor = true;
#else
constexpr bool feature_expeditor = false;
#endif
#ifdef FEATURE_PTHREADS
#undef FEATURE_PTHREADS
constexpr bool feature_pthreads = true;
#else
constexpr bool feature_pthreads = false;
#endif

/* Locking macros. */
inline void init_lock(ptr addr) {
	INITLOCK(addr);
}
#undef INITLOCK

inline void spinlock(ptr addr) {
	SPINLOCK(addr);
}
#undef SPINLOCK

inline void unlock(ptr addr) {
	UNLOCK(addr);
}
#undef UNLOCK

void locked_incr(ptr addr, uptr& ret) {
	LOCKED_INCR(addr, ret);
}
#undef LOCKED_INCR

void locked_decr(ptr addr, uptr& ret) {
	LOCKED_DECR(addr, ret);
}
#undef LOCKED_DECR

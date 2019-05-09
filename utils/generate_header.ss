(import (chezscheme))
(define (define_cstr sym)
  (define str (symbol->string sym))
  (define lc (string-downcase str))
  (define uc (string-upcase str))
  (printf "constexpr char* ~a = ~a;\n" lc uc)
  (printf "#undef ~s\n" uc))

(define (define_predicate p)
  (printf "inline bool ~s(ptr x) {\n" p)
  (printf "  return S~s(x); \n" p)
  (printf "}\n")
  (printf "#undef S~s\n" p))

(define (define_accessor acc ret)
  (printf "inline ~a ~a(ptr x) {\n" ret acc)
  (printf "  return S~s(x); \n" acc)
  (printf "}\n"))

(define (define_index_accessor acc ret)
  (printf "inline ~a ~a(ptr x, std::size_t idx) {\n" ret acc)
  (printf "  return S~s(x, idx); \n" acc )
  (printf "}\n"))

(define (define_undef x)
  (printf "#undef ~a" x))

(define-syntax multi_define_cstr
  (syntax-rules ()
    [(_ e ...) (begin (begin (define_cstr 'e) (newline))...)]))

(define-syntax multi_define_predicate
  (syntax-rules ()
    [(_ e ...) (begin (begin (define_predicate 'e) (newline))...)]))

(define-syntax multi_define_accessor (lambda (x)
  (let ([helper (lambda (x)
                 (let ([nx (string-append "S" (symbol->string (syntax->datum x)))]) #`(begin (define_undef '#,nx) (newline))))])
  (syntax-case x ()
    [(_ (e1 e2) ...) (list #'begin #'(begin (define_accessor 'e1 'e2) ...) (cons #'begin (map helper #'(e1 ...))))]))))

(define-syntax multi_define_index_accessor (lambda (x)
  (let ([helper (lambda (x)
                 (let ([nx (string-append "S" (symbol->string (syntax->datum x)))]) #`(begin (define_undef '#,nx) (newline))))])
  (syntax-case x ()
    [(_ (e1 e2) ...) (list #'begin #'(begin (define_index_accessor 'e1 'e2) ...) (cons #'begin (map helper #'(e1 ...))))]))))

(multi_define_cstr VERSION MACHINE_TYPE)
(multi_define_predicate fixnum charp nullp eof_objectp bwp_objectp booleanp pairp symbolp procedurep flonump vectorp fxvectorp bytevectorp stringp bignump boxp inexactnump exactnump ratnump inputportp outputpotyp recordp)

(multi_define_accessor (fixnum_value iptr) (char_value string_char) (boolean_value bool) (car ptr) (cdr ptr) (flonum_value double) (vector_length iptr) (fxvector_length iptr) (bytevector_length iptr) (bytevector_data "octect *") (string_length iptr) (unbox ptr) (unsigned_value uptr) (unsigned32_value "unsigned int") (unsigned64_value "unsigned long"))
(multi_define_index_accessor (vector_ref ptr) (fxvector_ref ptr) (bytevector_u8_ref octet) (string_ref string_char))
(put-bytevector (standard-output-port) (get-bytevector-all (open-file-input-port "other.h")))

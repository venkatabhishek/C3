char *strcat(char * restrict dest,
             const char * restrict src : itype(restrict _Nt_array_ptr<const char>));

char *strncpy(char * restrict dest : count(n),
              const char * restrict src : count(n),
              size_t n) : bounds(dest, (_Array_ptr<char>)dest + n);

_Itype_for_any(T) void *memcpy(void * restrict dest : itype(restrict _Array_ptr<T>) byte_count(n),
             const void * restrict src : itype(restrict _Array_ptr<const T>) byte_count(n),
             size_t n) : itype(_Array_ptr<T>) byte_count(n);

struct foo {
  _Nt_array_ptr<char> p : count(len);
  int len;
};

void foo() {
  _Array_ptr<int> p : count(n) = 0;
  _Ptr<int> q = (_Ptr<int>)p;
  _Ptr<struct foo> q = malloc(sizeof(struct foo));
}  

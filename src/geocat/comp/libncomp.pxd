# cython: language_level=3
cdef extern from "ncomp/constants.h":
    cdef double DEFAULT_FILL "DEFAULT_FILL_DOUBLE";
    cdef char   DEFAULT_FILL_INT8 "NC_FILL_BYTE";
    cdef unsigned char   DEFAULT_FILL_UINT8 "NC_FILL_UBYTE";
    cdef short  DEFAULT_FILL_INT16 "NC_FILL_SHORT";
    cdef unsigned short  DEFAULT_FILL_UINT16 "NC_FILL_USHORT";
    cdef int    DEFAULT_FILL_INT32 "NC_FILL_INT";
    cdef unsigned int    DEFAULT_FILL_UINT32 "NC_FILL_UINT";
    cdef long   DEFAULT_FILL_INT64 "NC_FILL_INT64";
    cdef unsigned long   DEFAULT_FILL_UINT64 "NC_FILL_UINT64";
    cdef float  DEFAULT_FILL_FLOAT "NC_FILL_FLOAT";
    cdef double DEFAULT_FILL_DOUBLE "NC_FILL_DOUBLE";
    cdef char   DEFAULT_FILL_CHAR "DEFAULT_FILL_CHAR";

cdef extern from "ncomp/types.h":
    cdef enum NcompTypes:
        NCOMP_BOOL
        NCOMP_BYTE
        NCOMP_UBYTE
        NCOMP_SHORT
        NCOMP_USHORT
        NCOMP_INT
        NCOMP_UINT
        NCOMP_LONG
        NCOMP_ULONG
        NCOMP_LONGLONG
        NCOMP_ULONGLONG
        NCOMP_FLOAT
        NCOMP_DOUBLE
        NCOMP_LONGDOUBLE

    ctypedef union ncomp_missing:
        char                msg_bool
        signed char         msg_byte
        unsigned char       msg_ubyte
        short               msg_short
        unsigned short      msg_ushort
        int                 msg_int
        unsigned int        msg_uint
        long                msg_long
        unsigned long       msg_ulong
        long long           msg_longlong
        unsigned long long  msg_ulonglong
        float               msg_float
        double              msg_double
        long double         msg_longdouble

    ctypedef struct ncomp_array:
        int             type
        int             ndim
        void*           addr
        int             has_missing
        ncomp_missing   msg
        size_t*         shape

    ctypedef struct ncomp_single_attribute:
        char *        name
        ncomp_array*  value

    ctypedef struct ncomp_attributes:
        int                        nAttribute
        ncomp_single_attribute **  attribute_array


cdef extern from "ncomp/util.h":
    ncomp_array* ncomp_array_alloc(void*, int, int, size_t*)
    void         ncomp_array_free(ncomp_array*, int)
    ncomp_single_attribute* create_ncomp_single_attribute(char *, void *, int, int, size_t *);
    ncomp_attributes* ncomp_attributes_allocate(int);

cdef extern from "ncomp/wrapper.h":
    int linint2(const ncomp_array*, const ncomp_array*, const ncomp_array*,
                const ncomp_array*, const ncomp_array*, ncomp_array*,
                int, int) nogil;

    int rcm2rgrid(const ncomp_array* lat2d, const ncomp_array* lon2d, const ncomp_array* fi,
                  const ncomp_array* lat1d, const ncomp_array* lon1d, ncomp_array* fo) nogil;

    int rgrid2rcm(const ncomp_array* lat1d, const ncomp_array* lon1d, const ncomp_array* fi,
                  const ncomp_array* lat2d, const ncomp_array* lon2d, ncomp_array* fo) nogil;

    int eofunc(const ncomp_array * x_in, const int neval_in,
               const ncomp_attributes * options_in,
               ncomp_array** x_out, ncomp_attributes* attrList_out) nogil;

    int eofunc_n(const ncomp_array * x_in, const int neval_in,
                 const int t_dim,
                 const ncomp_attributes * options_in,
                 ncomp_array ** x_out, ncomp_attributes * attrList_out) nogil;

    int eofunc_ts(
      const ncomp_array * x_in,
      const ncomp_array * evec_in,
      const ncomp_attributes * options_in,
      ncomp_array ** x_out,
      ncomp_attributes * attrs_out) nogil;

    int eofunc_ts_n(
        const ncomp_array * x_in,
        const ncomp_array * evec_in,
        const ncomp_attributes * options_in,
        const int t_dim,
        ncomp_array ** x_out,
        ncomp_attributes * attrs_out) nogil;

    int moc_globe_atl( const ncomp_array *, const ncomp_array *, const ncomp_array *,
                      const ncomp_array *, const ncomp_array *, const ncomp_array *,
                      ncomp_array ** ) nogil;

    int dpres_plevel( const ncomp_array *, const ncomp_array *, const ncomp_array *,
                      ncomp_array ** ) nogil;

    int rcm2points(const ncomp_array* lat2d, const ncomp_array* lon2d, const ncomp_array* fi,
                   const ncomp_array* lat1d, const ncomp_array* lon1d, ncomp_array* fo, int) nogil;

    int triple2grid(const ncomp_array * x, const ncomp_array * y, const ncomp_array * data,
                    const ncomp_array * xgrid, const ncomp_array * ygrid, ncomp_array ** output,
                    const ncomp_attributes * options_in) nogil;

    int grid2triple(const ncomp_array * x, const ncomp_array * y, const ncomp_array * z,
                    ncomp_array ** output) nogil;

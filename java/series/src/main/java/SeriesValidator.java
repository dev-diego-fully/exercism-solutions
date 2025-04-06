class SeriesValidator {

    static final String EMPTY_STRING_MSG = "series cannot be empty";
    static final String NEGATIVE_SLICE_LEN_MSG = "slice length cannot be negative or zero";
    static final String SLICE_BIGGER_THAN_SOURCE_MSG = "slice length cannot be greater than series length";

    static void ensureNonEmptySeries(String source) {
        if (source.length() == 0) {
            throw new IllegalArgumentException(EMPTY_STRING_MSG);
        }
    }

    static void ensureValidSliceLength(int sliceLen, String source) {
        ensurePositiveSliceLength(sliceLen);
        ensureSliceSmallerThanSource(sliceLen, source);
    }

    private static void ensurePositiveSliceLength(int sliceLen) {
        if (sliceLen < 1) {
            throw new IllegalArgumentException(NEGATIVE_SLICE_LEN_MSG);
        }
    }

    private static void ensureSliceSmallerThanSource(int sliceLen, String source) {
        if (sliceLen > source.length()) {
            throw new IllegalArgumentException(SLICE_BIGGER_THAN_SOURCE_MSG);
        }
    }

}

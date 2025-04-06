class SeriesValidator {

    static final String NEGATIVE_SLICE_LEN_MSG = "Series length must be non-negative.";
    static final String SLICE_BIGGER_THAN_SOURCE_MSG = "Series length must be less than or equal to the length of the string to search.";

    static void ensureValidSliceLength(int sliceLen, String source) {
        ensurePositiveSliceLength(sliceLen);
        ensureSliceSmallerThanSource(sliceLen, source);
    }

    private static void ensurePositiveSliceLength(int sliceLen) {
        if (sliceLen < 0) {
            throw new IllegalArgumentException(NEGATIVE_SLICE_LEN_MSG);
        }
    }

    private static void ensureSliceSmallerThanSource(int sliceLen, String source) {
        if (sliceLen > source.length()) {
            throw new IllegalArgumentException(SLICE_BIGGER_THAN_SOURCE_MSG);
        }
    }

}

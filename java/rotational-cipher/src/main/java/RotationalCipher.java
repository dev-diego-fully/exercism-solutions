class RotationalCipher {

    final int ALPHABET_SIZE = 26;
    private final int shiftKey;

    RotationalCipher(int shiftKey) {
        this.shiftKey = shiftKey;
    }

    String rotate(String data) {
        return data
                .codePoints()
                .map(this::rotate)
                .collect(
                        StringBuilder::new,
                        StringBuilder::appendCodePoint,
                        StringBuilder::append)
                .toString();
    }

    Integer rotate(int codePoint) {
        if (!Character.isAlphabetic(codePoint)) {
            return codePoint;
        }
        final int caseStart = Character.isUpperCase(codePoint) ? 'A' : 'a';
        final int letterIndex = codePoint - caseStart;
        final int newLetterIndex = (letterIndex + this.shiftKey) % ALPHABET_SIZE;

        return caseStart + newLetterIndex;
    }

}

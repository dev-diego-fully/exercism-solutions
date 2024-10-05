class SqueakyClean {

    private static String capitalize(String word) {
        return Character.toUpperCase(word.charAt(0)) + word.substring(1);
    }

    private static String cleanSpace(String identifier) {
        return identifier.replace(' ', '_');
    }

    private static String cleanKebabCase(String identifier) {
        String[] words = identifier.split("-");
        String cleaned = words[0];

        for( int i = 1; i < words.length; i++ ) {
            cleaned += SqueakyClean.capitalize(words[i]);
        }
        
        return cleaned;
    }

    private static String cleanLeetSpeak(String identifier) {
        return identifier.replace('4', 'a')
                .replace('3', 'e')
                .replace('0', 'o')
                .replace('1', 'l')
                .replace('7', 't');
    }

    private static String cleanNonLetters(String identifier) {
        return identifier.replaceAll("[^a-zA-Z_]", "");
    }

    public static String clean(String identifier) {
        String cleaned = identifier;

        cleaned = cleanSpace(cleaned);
        cleaned = cleanKebabCase(cleaned);
        cleaned = cleanLeetSpeak(cleaned);
        cleaned = cleanNonLetters(cleaned);

        return cleaned;
    }
}

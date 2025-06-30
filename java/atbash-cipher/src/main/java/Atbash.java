class Atbash {

    private static final int ALPHABET_START = (int)'a';
    private static final int ALPHABET_END = (int)'z';
    
    String encode(String input) {
        return input.chars()
        			.map(Character::toLowerCase)
        			.filter(this::isAlphaOrDigit)	
                    .map(this::translateIfIsLetter)
                    .mapToObj(chr -> (char)chr) 
                    .collect(StringBuilder::new, this::insertInterspacing, StringBuilder::append)
                    .toString();
    }

    String decode(String input) {
        return input.chars()
        			.filter(this::isAlphaOrDigit)
        			.map(this::translateIfIsLetter)
        			.mapToObj(chr -> (char)chr)
        			.collect(StringBuilder::new, StringBuilder::append, StringBuilder::append)
        			.toString();
    }

    private boolean isAlphaOrDigit(int code) {
        return Character.isAlphabetic(code) || Character.isDigit(code);
    }

    private int translateIfIsLetter(int charCode) {
    	if(charCode >= 'a' && charCode <= 'z') {
    		return ALPHABET_END - (charCode - ALPHABET_START);
    	}
    	return charCode;
    }

    private StringBuilder insertInterspacing(StringBuilder builder, char current) {
        if(builder.length() % 6 == 5) {
            builder.append(' ');
        }
        builder.append(current);
        return builder;
    }
    
}

import java.util.List;
import java.util.regex.MatchResult;
import java.util.regex.Pattern;
import main.java.TranslationResult;

class ProteinTranslator {

    public List<String> translate(String rnaSequence) {
        return codonPattern
                .matcher(rnaSequence)
                .results()
                .map(MatchResult::group)
                .map(TranslationResult::fromCodon)
                .takeWhile((result) -> !result.equals(TranslationResult.STOP))
                .map(TranslationResult::getProteinName)
                .toList();
    }

    private static final Pattern codonPattern = Pattern.compile("[^\s]{1,3}");
}

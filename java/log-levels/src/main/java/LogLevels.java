public class LogLevels {

    public static String message(String logLine) {
        final String messagePredecessor = ":";
        
        int messageStart = logLine.indexOf(messagePredecessor) + 1;
        
        return logLine.substring(messageStart).trim();
    }

    public static String logLevel(String logLine) {
        final String logLevelPredecessor = "[";
        final String logLevelSucessor = "]";

        int logLevelStart = logLine.indexOf(logLevelPredecessor) + 1;
        int logLevelEnd = logLine.indexOf(logLevelSucessor);

        return logLine.substring(logLevelStart, logLevelEnd).toLowerCase();
    }

    public static String reformat(String logLine) {
        final String newFormat = "%s (%s)";

        String message = LogLevels.message(logLine);
        String logLevel = LogLevels.logLevel(logLine);
        
        return String.format(newFormat, message, logLevel);
    }
    
}

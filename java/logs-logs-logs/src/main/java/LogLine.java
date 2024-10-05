public class LogLine {

    //attributes
    private String logLine = "";

    //constructors
    public LogLine(String logLine) {
        this.logLine = logLine;
    }

    //methods
    public LogLevel getLogLevel() {
        final int logLevelStart = 1;
        final int logLevelEnd = logLevelStart + 3;

        return LogLevel.from(
            this.logLine.substring(logLevelStart, logLevelEnd)
        );
    }

    public String getOutputForShortLog() {
        final String shortLogTemplate = "%d:%s";
        final int messageStart = 7;

        final int encode = this.getLogLevel().getEncode();
        final String message = this.logLine.substring(messageStart);

        return String.format(shortLogTemplate, encode, message);
    }
}

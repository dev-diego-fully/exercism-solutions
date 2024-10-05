public enum LogLevel {
    TRACE(1),
    DEBUG(2),
    INFO(4),
    WARNING(5),
    ERROR(6),
    FATAL(42),
    UNKNOWN(0);

    //static mehtods
    public static LogLevel from(String logLevel) {
        return switch(logLevel) {
            case "TRC" -> LogLevel.TRACE;
            case "DBG" -> LogLevel.DEBUG;
            case "INF" -> LogLevel.INFO;
            case "WRN" -> LogLevel.WARNING;
            case "ERR" -> LogLevel.ERROR;
            case "FTL" -> LogLevel.FATAL;
            default -> LogLevel.UNKNOWN;
        };
    }

    //attributes
    private int encode = 0;

    //constructor
    LogLevel(int encode) {
        this.encode = encode;
    }

    //methods
    public int getEncode() {
        return this.encode;
    }
}

class CalculatorConundrum {

    private int getResult(String operation, int operand1, int operand2) {
        return switch (operation) {
            case "+" -> operand1 + operand2;
            case "*" -> operand1 * operand2;
            case "/" -> operand1 / operand2;
            default -> 0;
        };
    }

    private IllegalOperationException nonExistendOperationError(String operation) {
        final String errorMsgTemplate = "Operation '%s' does not exist";
        final String errorMsg = String.format(errorMsgTemplate, operation);

        return new IllegalOperationException(errorMsg);
    }

    private String formatedCalculation(String operation, int operand1, int operand2) {
        final String resultTemplate = "%d %s %d = %d";

        int result = this.getResult(operation, operand1, operand2);

        return String.format(resultTemplate, operand1, operation, operand2, result);
    }

    public String calculate(int operand1, int operand2, String operation) {
        if (operation == null) {
            throw new IllegalArgumentException("Operation cannot be null");
        }
        switch (operation) {
            case "":
                throw new IllegalArgumentException("Operation cannot be empty");
            case "+", "*":
                return this.formatedCalculation(operation, operand1, operand2);
            case "/":
                try {
                    return this.formatedCalculation(operation, operand1, operand2);
                } catch (ArithmeticException e) {
                    throw new IllegalOperationException("Division by zero is not allowed", e);
                }
            default:
                throw this.nonExistendOperationError(operation);
        }
    }
}

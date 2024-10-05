class Badge {
    public String print(Integer id, String name, String department) {
        final String defaultTemplate = "[%d] - %s - %s";
        final String newEmployeeTemplate = "%s - %s";
        final String ownerSymbol = "OWNER";
        
        if(department == null) {
            return this.print(id, name, ownerSymbol);
        }
        
        String printedDepartment = department.toUpperCase();
        if(id == null) {
            return String.format(newEmployeeTemplate, name, printedDepartment);
        }

        return String.format(defaultTemplate, id, name, printedDepartment);
    }

}

public class SalaryCalculator {
    public double salaryMultiplier(int daysSkipped) {
        return daysSkipped < 5 ? 1 : 0.85;
    }

    public int bonusMultiplier(int productsSold) {
        return productsSold >= 20 ? 13 : 10;
    }

    public double bonusForProductsSold(int productsSold) {
        return bonusMultiplier(productsSold) * productsSold;
    }

    public double finalSalary(int daysSkipped, int productsSold) {
        final double defaultSalary = 1000.0;

        double salary = salaryMultiplier(daysSkipped) * defaultSalary;
        double bonus = bonusForProductsSold(productsSold);
        double finalSalary = salary + bonus;

        return finalSalary < 2000 ? finalSalary : 2000;
    } 
}

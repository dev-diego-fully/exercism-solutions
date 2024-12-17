class ResistorColorTrio {

    public String label(String[] resistorColors) {
        final String a = resistorColors[0];
        final String b = resistorColors[1];
        final String c = resistorColors[2];

        return Resistor
                .fromColors(a, b, c)
                .getMetricResistance()
                .formatedAsHighest();
    }

}

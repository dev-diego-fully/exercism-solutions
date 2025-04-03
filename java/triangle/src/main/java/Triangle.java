import java.util.stream.Stream;

class Triangle {

    long distincts = 0;

    Triangle(double side1, double side2, double side3) throws TriangleException {
        if (!this.isTriangle(side1, side2, side3)) {
            throw new TriangleException();
        }
        this.distincts = Stream
                .of(side1, side2, side3)
                .distinct()
                .count();
    }

    boolean isEquilateral() {
        return this.distincts == 1;
    }

    boolean isIsosceles() {
        return this.distincts <= 2;
    }

    boolean isScalene() {
        return this.distincts == 3;
    }

    private boolean isTriangle(double side1, double side2, double side3) {
        if (Stream.of(side1, side2, side3).anyMatch((s) -> s <= 0)) {
            return false;
        }
        return (this.satisfyInequality(side2, side3, side1) &&
                this.satisfyInequality(side1, side3, side2) &&
                this.satisfyInequality(side1, side2, side3));
    }

    private boolean satisfyInequality(double side1, double side2, double side3) {
        return side1 + side2 >= side3;
    }

}

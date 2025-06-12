import java.util.List;
import java.util.Optional;
import java.util.stream.IntStream;
import java.util.stream.Stream;

class PythagoreanTriplet {

	private final int a;
	private final int b;
	private final int c;

	PythagoreanTriplet(int a, int b, int c) {
		this.a = a;
		this.b = b;
		this.c = c;
	}

	@Override
	public boolean equals(Object obj) {
		if (obj instanceof PythagoreanTriplet) {
			final PythagoreanTriplet other = (PythagoreanTriplet) obj;
			return this.a == other.a && this.b == other.b && this.c == other.c;
		}
		return false;
	}

	@Override
	public String toString() {
		return "<" + this.a + ";" + this.b + ";" + this.c + ">";
	}

	static TripletListBuilder makeTripletsList() {
		return (new TripletListBuilder());
	}

	static class TripletListBuilder {

		private Stream<PythagoreanTriplet> triplets;
		private int maxFactor = Integer.MAX_VALUE;

		TripletListBuilder thatSumTo(int sum) {
			this.triplets = PythagoreanTriplet.tripletsWith(sum, this.maxFactor);
			return this;
		}

		TripletListBuilder withFactorsLessThanOrEqualTo(int maxFactor) {
			this.maxFactor = maxFactor;
			return this;
		}

		List<PythagoreanTriplet> build() {
			return this.triplets.toList();
		}

	}

	private static Stream<PythagoreanTriplet> tripletsWith(int sum, int maxFactor) {
		return IntStream
					.rangeClosed(1, Math.min(sum, maxFactor))
					.mapToObj((v) -> (int) v)
					.flatMap((a) -> PythagoreanTriplet.tripletsWith(sum, maxFactor, a));
	}

	private static Stream<PythagoreanTriplet> tripletsWith(int sum, int maxFactor, int a) {
		return IntStream.rangeClosed(a + 1, Math.min(sum - a, maxFactor))
				.mapToObj((b) -> PythagoreanTriplet.tripletWith(sum, maxFactor, a, b))
				.filter(Optional::isPresent)
				.map(Optional::get);
	}

	private static Optional<PythagoreanTriplet> tripletWith(int sum, int maxFactor, int a, int b) {
		int c = sum - (a + b);
		
		if(c > maxFactor) {
			return Optional.empty();
		}
		
		if (c < a || c < b) {
			return Optional.empty();
		}

		if (Math.pow(a, 2) + Math.pow(b, 2) != Math.pow(c, 2)) {
			return Optional.empty();
		}

		return Optional.of(new PythagoreanTriplet(a, b, c));
	}

}
import java.util.HashMap;
import java.util.Map;

public class DialingCodes {

    private final Map<Integer, String> dialings = new HashMap<>();

    public Map<Integer, String> getCodes() {
        return this.dialings;
    }

    public void setDialingCode(Integer code, String country) {
        this.dialings.put(code, country);
    }

    public String getCountry(Integer code) {
        return this.dialings.get(code);
    }

    public void addNewDialingCode(Integer code, String country) {
        if (this.dialings.containsKey(code)) {
            return;
        }
        if (this.dialings.containsValue(country)) {
            return;
        }

        this.dialings.put(code, country);
    }

    public Integer findDialingCode(String country) {
        return this.dialings
                .keySet()
                .stream()
                .filter(key -> this.dialings.get(key) != null)
                .filter(key -> this.dialings.get(key).equals(country))
                .findFirst()
                .orElse(null);
    }

    public void updateCountryDialingCode(Integer code, String country) {
        final Integer prevCode = this.findDialingCode(country);
        if (prevCode != null) {
            this.dialings.remove(prevCode);
            this.dialings.put(code, country);
        }
    }
}

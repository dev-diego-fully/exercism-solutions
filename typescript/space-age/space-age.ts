type SolarSystemPlanet = "mercury" | "venus" | "mars" | "earth" | "jupiter" | "saturn" | "uranus" | "neptune";

export function age(planet: SolarSystemPlanet, seconds: number): number {
  return round(
    seconds/orbitalPeriod[planet]/earthYearInSeconds,
    agePrecision
  );
}

function round(num: number, precisionDigits: number) {
  const factor = Math.pow(10, precisionDigits);
  
  return Math.round(num * factor) / factor;
}

const agePrecision = 2;
const earthYearInSeconds: number = 60 * 60 * 24 * 365.25;
const orbitalPeriod: Record<SolarSystemPlanet, number> = {
  mercury: 0.2408467,
  venus: 0.61519726,
  earth: 1.0,
  mars: 1.8808158,
  jupiter: 11.862615,
  saturn: 29.447498,
  uranus: 84.016846,
  neptune: 164.79132
} as const;



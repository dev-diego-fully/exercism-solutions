export function twoFer(name?: string): string {
  const defaultPronomous: string = "you";

  return `One for ${name ? name : defaultPronomous}, one for me.`;
}

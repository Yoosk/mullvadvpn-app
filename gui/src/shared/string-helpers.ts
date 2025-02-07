export function capitalize(inputString: string): string {
  return inputString.charAt(0).toUpperCase() + inputString.slice(1);
}

export function capitalizeEveryWord(inputString: string): string {
  return inputString.split(' ').map(capitalize).join(' ');
}

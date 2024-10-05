export default function findAllContains(searchString: string, arr: string[]): string[] {
  return arr.filter(element => element.includes(searchString));
}

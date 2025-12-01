export function formatDateTimeShort(dateStr?: string): string {
  if (!dateStr) return "-";
  const date = new Date(dateStr);
  if (Number.isNaN(date.getTime())) return "-";

  return date.toLocaleString("pt-BR", {
    day: "2-digit",
    month: "2-digit",
    hour: "2-digit",
    minute: "2-digit",
  });
}

export function formatDateTimeLong(dateStr?: string): string {
  if (!dateStr) return "-";
  const date = new Date(dateStr);
  if (Number.isNaN(date.getTime())) return "-";

  return date.toLocaleString("pt-BR", {
    day: "2-digit",
    month: "2-digit",
    year: "numeric",
    hour: "2-digit",
    minute: "2-digit",
  });
}

export function formatNumber(
  value?: number,
  decimals: number = 1,
  suffix: string = ""
): string {
  if (value === undefined || value === null || Number.isNaN(value)) return "-";

  return (
    value
      .toLocaleString("pt-BR", {
        minimumFractionDigits: decimals,
        maximumFractionDigits: decimals,
      })
      .toString() + (suffix ? ` ${suffix}` : "")
  );
}

export function formatTemperature(value?: number): string {
  return formatNumber(value, 1, "°C");
}

export function formatPressure(value?: number): string {
  return formatNumber(value, 2, "bar");
}

export function formatHours(value?: number): string {
  return formatNumber(value, 1, "h");
}

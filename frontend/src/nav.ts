// Universal navigation & asset helpers for CineReserve
// Works seamlessly on Localhost, GitHub Pages, Vercel, Netlify, and custom domains

export function getAssetUrl(path: string): string {
  if (!path) return "";
  if (path.startsWith("http://") || path.startsWith("https://") || path.startsWith("data:")) {
    return path;
  }
  const clean = path.replace(/^\/+/, "");
  const pathname = typeof window !== "undefined" ? window.location.pathname : "";
  if (pathname.startsWith("/CineReserve")) {
    return `/CineReserve/${clean}`;
  }
  return `/${clean}`;
}

export function getCurrentRoute(): string {
  // Check hash route first: e.g. "#/movies?genre=Action" -> "/movies"
  if (window.location.hash) {
    const raw = window.location.hash.replace(/^#\/?/, "");
    const clean = raw.split("?")[0].replace(/\/+$/, "");
    if (clean) {
      return `/${clean}`;
    }
    return "/";
  }

  // Fallback to pathname (stripping subpath like /CineReserve)
  let path = window.location.pathname;
  const base = (import.meta.env.BASE_URL || "/").replace(/\/+$/, "");
  if (base && path.startsWith(base)) {
    path = path.slice(base.length);
  } else if (path.startsWith("/CineReserve")) {
    path = path.slice("/CineReserve".length);
  }
  path = path.replace(/\/+$/, "");
  return path === "" ? "/" : path;
}

export function getRouteParams(): URLSearchParams {
  // Check hash query first: "#/booking?movie=Doctor+Strange"
  if (window.location.hash && window.location.hash.includes("?")) {
    const hashQuery = window.location.hash.split("?")[1];
    return new URLSearchParams(hashQuery);
  }
  if (window.location.search && window.location.search !== "?") {
    return new URLSearchParams(window.location.search);
  }
  return new URLSearchParams();
}

export function getRouteHref(route: string, params?: Record<string, string>): string {
  const cleanRoute = route.startsWith("/") ? route.slice(1) : route;
  let queryString = "";
  if (params && Object.keys(params).length > 0) {
    const sp = new URLSearchParams(params);
    queryString = `?${sp.toString()}`;
  }
  // Hash route guarantees zero 404 errors on GitHub Pages & static hosting
  return `#/${cleanRoute}${queryString}`;
}

export function navigate(route: string, params?: Record<string, string>): void {
  const cleanRoute = route.startsWith("/") ? route.slice(1) : route;
  let queryString = "";
  if (params && Object.keys(params).length > 0) {
    const sp = new URLSearchParams(params);
    queryString = `?${sp.toString()}`;
  }
  const hashTarget = `#/${cleanRoute}${queryString}`;
  if (window.location.hash === hashTarget) {
    window.dispatchEvent(new HashChangeEvent("hashchange"));
  } else {
    window.location.hash = hashTarget;
  }
  window.scrollTo({ top: 0, behavior: "smooth" });
}

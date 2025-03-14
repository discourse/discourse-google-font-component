import { apiInitializer } from "discourse/lib/api";
import GoogleFonts from "../components/google-fonts";

export default apiInitializer("1.0", (api) => {
  api.renderInOutlet("above-site-header", GoogleFonts);
});

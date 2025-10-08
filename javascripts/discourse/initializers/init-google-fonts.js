import { apiInitializer } from "discourse/lib/api";
import GoogleFonts from "../components/google-fonts";

export default apiInitializer((api) => {
  api.renderInOutlet("above-site-header", GoogleFonts);
});

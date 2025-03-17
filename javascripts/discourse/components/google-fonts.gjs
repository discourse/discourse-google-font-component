import Component from "@glimmer/component";

export default class GoogleFonts extends Component {
  get fontLink() {
    const fonts = settings.fonts;
    const bodyFont = settings.body_font;
    const bodyFontWeight = settings.body_font_weight || "400";
    const headlineFont = settings.headline_font;
    const headlineFontWeight = settings.headline_font_weight || "700";
    const monospacedFont = settings.monospaced_font;
    const monospacedFontWeight = settings.monospaced_font_weight || "400";

    if (!fonts) {
      return;
    }

    const fontFamilies = fonts.split("|");
    const fontConfigs = [];

    fontFamilies.forEach((fontFamily) => {
      if (!fontFamily.trim()) {
        return;
      }

      let fontConfig = `family=${fontFamily.trim().replace(/ /g, "+")}`;
      let weights = "400;700"; // default regular and bold weight
      let isBodyFont = false;

      if (fontFamily === bodyFont) {
        weights = this.getWeightRange(bodyFontWeight);
        isBodyFont = true;
      } else if (fontFamily === headlineFont) {
        weights = this.getWeightRange(headlineFontWeight);
      } else if (fontFamily === monospacedFont) {
        weights = this.getWeightRange(monospacedFontWeight);
      }

      const sortedWeights = weights
        .split(";")
        .sort((a, b) => parseInt(a, 10) - parseInt(b, 10));

      // tuples must be sorted or the API will error
      // if debugging, check the endpoint in the browser for error messages
      if (isBodyFont) {
        const sortedTuples = [];
        sortedWeights.forEach((weight) => sortedTuples.push(`0,${weight}`));
        sortedWeights.forEach((weight) => sortedTuples.push(`1,${weight}`));
        fontConfig += `:ital,wght@${sortedTuples.join(";")}`;
      } else {
        fontConfig += `:wght@${sortedWeights.join(";")}`;
      }

      fontConfigs.push(fontConfig);
    });

    return fontConfigs.length ? fontConfigs.join("&") : null;
  }

  getWeightRange(weight) {
    const weightNum = parseInt(weight, 10) || 400;
    const weights = new Set([400, weightNum]);

    weights.add(700);

    if (weightNum < 400) {
      weights.add(weightNum);
    }

    return Array.from(weights)
      .sort((a, b) => a - b)
      .join(";");
  }

  <template>
    {{#if this.fontLink}}
      <link rel="preconnect" href="https://fonts.googleapis.com" />
      <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
      <link
        rel="stylesheet"
        href="https://fonts.googleapis.com/css2?{{this.fontLink}}&display=swap"
      />
    {{/if}}
  </template>
}

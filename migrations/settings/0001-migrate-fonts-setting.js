// This migration removes the weights from the old formatting and just leaves the font names

export default function migrate(settings) {
  if (settings.has("fonts") && settings.get("fonts")) {
    const oldFontsValue = settings.get("fonts");

    const fontFamilies = oldFontsValue.split("|");

    const processedFontFamilies = fontFamilies.map((fontSpec) => {
      if (fontSpec.includes(":")) {
        const [fontName] = fontSpec.split(":");

        return fontName.trim();
      }
      return fontSpec;
    });

    settings.set("fonts", processedFontFamilies.join("|"));
  }

  return settings;
}

# Your turn 2: one brand, two modes

`_brand.yml` is the one you wrote in your turn 1.

Somebody reads this release at night. 
Give the brand a dark appearance without writing a second brand.

1. In `_brand.yml`, give three roles a value per mode:

   ```yaml
     background:
       light: white
       dark: ink
     foreground:
       light: ink
       dark: sand
     primary:
       light: forest
       dark: forest
   ```

2. Add the dark half to `report.qmd` so you can see it:

   ```yaml
   format:
     html:
       respect-user-color-scheme: true
   ```

3. Render, open `report.html` in a browser, and switch your system appearance to dark. 
   On macOS: **System Settings** > **Appearance**. 
   On Windows: **Settings** > **Personalization** > **Colors**. 
   Switch back and forth with the page open.

4. Look at the link to the methodology notes in dark mode. Forest on ink is not legible.

5. Add a lighter green to the palette and use it for the dark half of `primary`:

   ```yaml
     palette:
       forest: "#1B5E4F"
       mint: "#7FBFA8"
       ...
   ```

   ```yaml
     primary:
       light: forest
       dark: mint
   ```

6. Render and check the link again in both appearances.

7. **Stretch goal:** Give `secondary` and `tertiary` mode values too, then find something in the document that uses them. 
   If nothing does, that tells you something about which roles this document actually exercises.

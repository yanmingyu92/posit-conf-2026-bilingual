# Your turn 3: add the release status

Statistical releases are marked with their status. A first estimate is
**Provisional**. A corrected estimate is **Revised**. A settled estimate is
**Final**. Not every release carries one.

This folder holds the finished work of turn 2: the masthead and the reference
period are both in `title-block.html`.

There is no snippet this time.

1. Add a `status` key under `brs-release:` in `report.qmd`:

   ```yaml
   brs-release:
     period: "Q3 2026"
     region: Oregon
     status: Provisional
   ```

2. In `title-block.html`, below the reference period, show the status inside
   this element:

   ```html
   <span class="report-status"></span>
   ```

   Show it only when `brs-release.status` is set.

3. Render. Then delete the `status:` line and render again. The badge should
   disappear, leaving nothing behind.

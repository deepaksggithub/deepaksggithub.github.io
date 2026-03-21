# Riveda LLC - SharePoint Online Version

This folder contains SharePoint Online-compatible files for deploying the Riveda LLC website.

## 📁 Files

| File | Description |
|------|-------------|
| **riveda-content.html** | Main HTML content (without `<html>`, `<head>`, or `<body>` tags) |
| **riveda-styles.css** | Scoped CSS styles (all prefixed with `.riveda-site`) |
| **riveda-script.js** | JavaScript for interactions and animations |
| **riveda-all-in-one.html** | Single file with inline CSS/JS (easiest deployment) |
| **DEPLOYMENT-GUIDE.md** | Complete deployment instructions |
| **README.md** | This file |

## 🚀 Quick Deploy (3 Options)

### Option 1: All-in-One (Easiest)
1. Open `riveda-all-in-one.html` in a text editor
2. Copy the entire contents
3. In SharePoint, create a new modern page
4. Add an "Embed" web part
5. Paste the code
6. Publish

**Note:** This file has CSS/JS inline, but you'll need to manually add the full HTML content from `riveda-content.html` where indicated.

### Option 2: Separate Files (Recommended)
1. Upload `riveda-styles.css` and `riveda-script.js` to SharePoint Site Assets
2. Update the file paths in `riveda-content.html`
3. Copy the updated HTML to an Embed web part
4. Publish

### Option 3: Multiple Pages
Split the content into multiple SharePoint pages for better organization.

## 📖 Full Instructions

See **[DEPLOYMENT-GUIDE.md](./DEPLOYMENT-GUIDE.md)** for complete step-by-step instructions, troubleshooting, and customization options.

## ✨ Features

- ✅ Fully responsive (mobile, tablet, desktop)
- ✅ Scoped CSS (no conflicts with SharePoint)
- ✅ No navigation (uses SharePoint's built-in nav)
- ✅ Scroll animations
- ✅ Contact form with validation
- ✅ Font Awesome icons
- ✅ Google Fonts (Inter)

## 🔧 Customization

All styles are scoped to `.riveda-site` and use CSS custom properties (variables) for easy customization. Edit `riveda-styles.css` and change:

```css
:root {
    --riveda-sp: #0078D4;   /* SharePoint color */
    --riveda-pa: #742774;   /* Power Apps color */
    --riveda-pf: #0F6CBD;   /* Power Automate color */
}
```

## 📞 Need Help?

Check the deployment guide or contact your SharePoint administrator.

---

**Version:** 1.0 (SharePoint Online Modern)
**Last Updated:** 2024

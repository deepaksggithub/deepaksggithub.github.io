# Riveda LLC - SharePoint Online Deployment Guide

This guide will walk you through deploying the Riveda LLC website to SharePoint Online modern pages.

## 📦 Files Included

- **riveda-content.html** - Main content (without navigation)
- **riveda-styles.css** - Scoped styles
- **riveda-script.js** - JavaScript for interactions
- **DEPLOYMENT-GUIDE.md** - This file

---

## 🚀 Quick Start (3 Steps)

### Step 1: Upload Assets to SharePoint

1. **Navigate to your SharePoint site** (e.g., `https://yourtenant.sharepoint.com/sites/yoursite`)

2. **Upload CSS and JS files:**
   - Go to **Site Contents** → **Site Assets** (or create a new document library called "Assets")
   - Create a folder called `riveda` inside Site Assets
   - Upload `riveda-styles.css` and `riveda-script.js` to this folder

3. **Note the file URLs** (you'll need these):
   ```
   CSS: /sites/yoursite/SiteAssets/riveda/riveda-styles.css
   JS:  /sites/yoursite/SiteAssets/riveda/riveda-script.js
   ```

---

### Step 2: Create a Modern Page

1. **Create a new SharePoint page:**
   - Go to **Pages** library
   - Click **+ New** → **Site page**
   - Name it `Riveda Home` or similar
   - Choose a blank template

2. **Add the Embed web part:**
   - Click **+** to add a web part
   - Search for **"Embed"**
   - Add the Embed web part to the page

---

### Step 3: Add the Content

1. **Open the HTML file** (`riveda-content.html`) in a text editor

2. **Create the complete HTML with asset links:**

   Replace the first line of `riveda-content.html` with:

   ```html
   <!-- Font Awesome Icons -->
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

   <!-- Riveda Styles -->
   <link rel="stylesheet" href="/sites/yoursite/SiteAssets/riveda/riveda-styles.css">

   <!-- Riveda Content -->
   ```

   **IMPORTANT:** Replace `/sites/yoursite/` with your actual SharePoint site URL path!

3. **Add the script reference** at the end of the HTML (before the closing `</div>`):

   ```html
   <!-- Riveda Script -->
   <script src="/sites/yoursite/SiteAssets/riveda/riveda-script.js"></script>
   </div>
   ```

4. **Copy the entire HTML** and paste it into the Embed web part's code section

5. **Publish the page**

---

## 📋 Detailed Instructions

### Option A: Using Embed Web Part (Recommended)

The Embed web part allows you to add HTML, CSS, and JavaScript to modern SharePoint pages.

**Steps:**

1. Edit your SharePoint page
2. Add an **Embed web part**
3. Paste your HTML code (with CSS and JS links)
4. Resize the web part to full width
5. Publish

**Limitations:**
- Some JavaScript features may be restricted by SharePoint's security policies
- External scripts from CDNs (like Font Awesome) should work fine

---

### Option B: Using Script Editor Web Part (Classic Sites)

If you're on SharePoint Classic:

1. Edit the page
2. Add **Script Editor** web part
3. Click "Edit Snippet"
4. Paste your HTML with inline `<style>` and `<script>` tags
5. Save

---

### Option C: Multiple Pages (Advanced)

You can split the content into multiple SharePoint pages:

- **Home page** - Hero + Platform Overview
- **Services page** - All three service sections
- **About page** - About + Process + Why Choose Us
- **Contact page** - Contact form

For each page, extract the relevant `<section>` from `riveda-content.html` and embed it.

---

## 🔗 Hosting Assets (Best Practices)

### Recommended Structure:

```
Site Assets/
└── riveda/
    ├── riveda-styles.css
    ├── riveda-script.js
    └── images/ (if you add images later)
```

### Alternative: Style Library

For better organization, you can use the **Style Library**:

```
Style Library/
└── riveda/
    ├── riveda-styles.css
    └── riveda-script.js
```

Access via: `/Style Library/riveda/riveda-styles.css`

---

## 🎨 Customization

### Updating Styles

1. Edit `riveda-styles.css` in Site Assets
2. Save the file
3. Clear your browser cache (Ctrl+F5)
4. Refresh the SharePoint page

### Updating Content

1. Edit the SharePoint page
2. Edit the Embed web part
3. Update the HTML
4. Republish

### Changing Colors

All colors are defined as CSS variables in `riveda-styles.css`:

```css
:root {
    --riveda-sp: #0078D4;   /* SharePoint blue */
    --riveda-pa: #742774;   /* Power Apps purple */
    --riveda-pf: #0F6CBD;   /* Power Automate blue */
    /* ... */
}
```

Edit these to match your branding.

---

## 🔒 Permissions

Ensure users have **Read** permissions to:
- Site Assets library (for CSS/JS files)
- Pages library (for the page itself)

---

## 📱 Mobile Responsiveness

The site is fully responsive and will adapt to mobile devices automatically. Test on:
- Desktop (1920px+)
- Tablet (768px - 1024px)
- Mobile (< 768px)

---

## 🐛 Troubleshooting

### Issue: Styles not loading

**Solution:**
1. Check the CSS file path in your HTML
2. Ensure the path is relative to your site: `/sites/yoursite/SiteAssets/...`
3. Verify file permissions (users need Read access)
4. Clear browser cache

### Issue: JavaScript not working

**Solution:**
1. Check browser console for errors (F12 → Console tab)
2. Verify the script path is correct
3. Some SharePoint tenants restrict custom scripts - check with your admin
4. Try adding `?rev=1` to the script URL to bypass cache: `riveda-script.js?rev=1`

### Issue: Embed web part not available

**Solution:**
- Modern sites only: Ensure you're on a modern SharePoint site, not classic
- Permissions: You need Edit rights on the page
- Alternative: Use the **Code** web part or **Markdown** web part with `<iframe>`

### Issue: Font Awesome icons not showing

**Solution:**
1. Ensure Font Awesome CDN link is included at the top of your HTML:
   ```html
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
   ```
2. Check your organization's Content Security Policy (CSP) - some orgs block external CDNs
3. Alternative: Download Font Awesome and host it in Site Assets

---

## 🔄 Updating the Site

When you need to update content or design:

1. **Quick content changes**: Edit the SharePoint page directly through the Embed web part
2. **Style updates**: Edit `riveda-styles.css` in Site Assets, increment `?rev=2` in the link tag
3. **Functionality updates**: Edit `riveda-script.js` in Site Assets

---

## 🚨 Important Notes

1. **Navigation**: SharePoint's built-in navigation is used. The original site's fixed header has been removed.

2. **Scoping**: All styles are scoped to `.riveda-site` to avoid conflicts with SharePoint's default styles.

3. **Form Submission**: The contact form currently shows a success message but doesn't submit anywhere. You can:
   - Connect it to a SharePoint list via REST API
   - Trigger a Power Automate flow
   - Use Microsoft Forms
   - Add a backend API endpoint

4. **Performance**: For best performance, consider:
   - Minifying CSS and JS files
   - Using a CDN for Font Awesome
   - Enabling SharePoint's CDN for your Site Assets

5. **Updates**: When SharePoint updates its UI, you may need to adjust styling to maintain visual consistency.

---

## 📞 Contact Form Integration (Optional)

To make the contact form functional in SharePoint:

### Option 1: SharePoint List + Power Automate

1. Create a SharePoint list called "Contact Submissions" with columns:
   - Name (Single line of text)
   - Email (Single line of text)
   - Service (Choice)
   - Message (Multiple lines of text)

2. Modify `riveda-script.js` to submit to the list using REST API:
   ```javascript
   // Add after form validation in riveda-script.js
   var listName = 'Contact Submissions';
   var url = _spPageContextInfo.webAbsoluteUrl +
             "/_api/web/lists/getbytitle('" + listName + "')/items";

   fetch(url, {
       method: 'POST',
       headers: {
           'Accept': 'application/json;odata=verbose',
           'Content-Type': 'application/json;odata=verbose',
           'X-RequestDigest': document.getElementById('__REQUESTDIGEST').value
       },
       body: JSON.stringify({
           '__metadata': { 'type': 'SP.Data.ContactSubmissionsListItem' },
           'Title': name,
           'Email': email,
           'Service': service,
           'Message': message
       })
   })
   .then(response => response.json())
   .then(data => {
       // Success
       submitBtn.innerHTML = '<i class="fa-solid fa-circle-check"></i> Message Sent!';
   });
   ```

3. Create a Power Automate flow triggered when items are added to this list to:
   - Send email notifications
   - Create tasks
   - Log to CRM

### Option 2: Microsoft Forms

Replace the contact form section with an embedded Microsoft Form:
1. Create a form in Microsoft Forms
2. Get the embed code
3. Replace the contact section with: `<iframe src="your-form-url" ...></iframe>`

### Option 3: Power Automate HTTP Trigger

1. Create a Power Automate flow with an HTTP trigger
2. Update the form submission in `riveda-script.js` to POST to the flow URL
3. Configure the flow to send emails, create items, etc.

---

## ✅ Go-Live Checklist

Before publishing to users:

- [ ] CSS and JS files uploaded to Site Assets
- [ ] File paths updated in HTML to match your site URL
- [ ] Page created and content embedded
- [ ] Tested on desktop, tablet, and mobile
- [ ] All links work (especially anchor links)
- [ ] Contact form tested (or disabled if not integrated)
- [ ] Permissions verified (users can view)
- [ ] Browser cache cleared for testing
- [ ] Tested in Edge, Chrome, and Safari
- [ ] SharePoint navigation configured
- [ ] Page added to site navigation

---

## 🎓 Additional Resources

- [SharePoint Modern Pages](https://support.microsoft.com/en-us/office/create-and-use-modern-pages-on-a-sharepoint-site-b3d46deb-27a6-4b1e-87b8-df851e503dec)
- [Embed Web Part](https://support.microsoft.com/en-us/office/use-the-embed-web-part-721f3b2f-437f-45ef-ac4e-df29dba74de8)
- [SharePoint REST API](https://learn.microsoft.com/en-us/sharepoint/dev/sp-add-ins/get-to-know-the-sharepoint-rest-service)
- [Power Automate Flows](https://flow.microsoft.com)

---

## 📧 Need Help?

If you encounter issues during deployment, contact your SharePoint administrator or IT support team.

---

**Last Updated:** 2024
**Version:** 1.0 (SharePoint Online)

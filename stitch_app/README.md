# GuardianNet — Smart Employee Monitoring System
### Flutter App (Converted from Stitch HTML/Tailwind Design)

---

## 🗂 Project Structure

```
stitch_app/
├── pubspec.yaml                   # Dependencies (flutter, go_router, google_fonts)
├── dartpad_previews/
│   └── login_preview.dart         # Paste into dartpad.dev to preview screens
├── android/
│   └── app/src/main/
│       └── AndroidManifest.xml    # App name: GuardianNet, permissions set
└── lib/
    ├── main.dart                  # Entry point — MaterialApp.router
    ├── theme/
    │   ├── app_colors.dart        # All 35 design tokens as Flutter Colors
    │   └── app_theme.dart         # ThemeData using google_fonts Inter
    ├── routes/
    │   └── app_routes.dart        # GoRouter — all 29 screens routed
    └── screens/
        ├── guardiannet_secure_login.dart         ✅ FULLY CONVERTED
        ├── admin_live_map_dashboard.dart          ✅ FULLY CONVERTED
        └── ... (27 placeholder screens)
```

---

## 🖥 Previewing Screens (No Flutter Install Needed)

Use **DartPad** — Flutter's official online IDE:

1. Go to **https://dartpad.dev**
2. Click **New Pad → Flutter Snippet**
3. Open `dartpad_previews/login_preview.dart` and paste the entire file
4. Click **▶ Run**

The GuardianNet login screen will render immediately in the browser.

---

## ☁️ Building the APK via GitHub Actions (No Local SDK)

This project uses **GitHub Actions** to build the APK in the cloud.

### Steps:
1. **Push this project to GitHub** (create a free repo at github.com)
2. The workflow at `.github/workflows/build_apk.yml` runs automatically on every push
3. Go to your repo → **Actions** tab → click the latest run
4. Download the APK from **Artifacts** at the bottom of the run page

```
Artifacts produced:
  guardiannet-debug-apk    → app-debug.apk   (for testing)
  guardiannet-release-apk  → app-release.apk (for distribution)
```

### Manual Trigger:
- Go to **Actions → Build Flutter APK → Run workflow** button

---

## 🎨 Design System

| Tailwind Token         | Flutter Constant              | Hex Value  |
|------------------------|-------------------------------|------------|
| `primary`              | `AppColors.primary`           | `#031632`  |
| `secondary`            | `AppColors.secondary`         | `#B7131A`  |
| `background`           | `AppColors.background`        | `#F8F9FF`  |
| `surface`              | `AppColors.surface`           | `#F8F9FF`  |
| `on-surface`           | `AppColors.onSurface`         | `#0B1C30`  |
| `outline`              | `AppColors.outline`           | `#75777E`  |
| `secondary-container`  | `AppColors.secondaryContainer`| `#DB322F`  |

Font: **Inter** via `google_fonts` package — loads at runtime, no manual download needed.

---

## 📱 Screens (29 Total)

| Screen | Status |
|--------|--------|
| `guardiannet_secure_login` | ✅ Fully Converted |
| `admin_live_map_dashboard` | ✅ Fully Converted |
| `welcome_to_guardiannet` | 🔲 Placeholder |
| `profile_setup` | 🔲 Placeholder |
| `identity_verification` | 🔲 Placeholder |
| `quick_start_live_tracking` | 🔲 Placeholder |
| `quick_start_safety_zones` | 🔲 Placeholder |
| `quick_start_emergency_sos` | 🔲 Placeholder |
| `personal_safety_portal` | 🔲 Placeholder |
| `personal_safety_portal_enhanced_map` | 🔲 Placeholder |
| `active_tracking_status` | 🔲 Placeholder |
| `geofencing_red_zones` | 🔲 Placeholder |
| `create_new_zone` | 🔲 Placeholder |
| `red_zone_settings_analytics` | 🔲 Placeholder |
| `team_management` | 🔲 Placeholder |
| `add_new_member` | 🔲 Placeholder |
| `edit_profile` | 🔲 Placeholder |
| `team_messages` | 🔲 Placeholder |
| `team_chat_with_member_list` | 🔲 Placeholder |
| `chat_elena_rodriguez` | 🔲 Placeholder |
| `unified_communication_portal` | 🔲 Placeholder |
| `notification_settings` | 🔲 Placeholder |
| `system_permissions_access` | 🔲 Placeholder |
| `remote_alarm_control` | 🔲 Placeholder |
| `safety_analytics_logs` | 🔲 Placeholder |
| `safety_automation_settings` | 🔲 Placeholder |
| `automated_messaging_rules` | 🔲 Placeholder |
| `guardiannet_enterprise_security_platform_1` | 🔲 Placeholder |
| `guardiannet_enterprise_security_platform_2` | 🔲 Placeholder |

---

## 🚀 Next Steps

1. **Push to GitHub** → APK builds automatically via Actions
2. **Preview more screens** → Add `dartpad_previews/dashboard_preview.dart`
3. **Convert placeholder screens** → Ask Antigravity to convert any screen by name

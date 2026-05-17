---
name: Sentinel Enterprise
colors:
  surface: '#f8f9ff'
  surface-dim: '#cbdbf5'
  surface-bright: '#f8f9ff'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#eff4ff'
  surface-container: '#e5eeff'
  surface-container-high: '#dce9ff'
  surface-container-highest: '#d3e4fe'
  on-surface: '#0b1c30'
  on-surface-variant: '#44474d'
  inverse-surface: '#213145'
  inverse-on-surface: '#eaf1ff'
  outline: '#75777e'
  outline-variant: '#c5c6ce'
  surface-tint: '#4e5f7e'
  primary: '#031632'
  on-primary: '#ffffff'
  primary-container: '#1a2b48'
  on-primary-container: '#8293b5'
  inverse-primary: '#b6c7eb'
  secondary: '#b7131a'
  on-secondary: '#ffffff'
  secondary-container: '#db322f'
  on-secondary-container: '#fffbff'
  tertiary: '#001c03'
  on-tertiary: '#ffffff'
  tertiary-container: '#003308'
  on-tertiary-container: '#48a54b'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#d7e2ff'
  primary-fixed-dim: '#b6c7eb'
  on-primary-fixed: '#081b38'
  on-primary-fixed-variant: '#374765'
  secondary-fixed: '#ffdad6'
  secondary-fixed-dim: '#ffb4ac'
  on-secondary-fixed: '#410002'
  on-secondary-fixed-variant: '#93000d'
  tertiary-fixed: '#98f994'
  tertiary-fixed-dim: '#7ddc7a'
  on-tertiary-fixed: '#002204'
  on-tertiary-fixed-variant: '#005313'
  background: '#f8f9ff'
  on-background: '#0b1c30'
  surface-variant: '#d3e4fe'
typography:
  headline-lg:
    fontFamily: Inter
    fontSize: 32px
    fontWeight: '700'
    lineHeight: 40px
    letterSpacing: -0.02em
  headline-lg-mobile:
    fontFamily: Inter
    fontSize: 24px
    fontWeight: '700'
    lineHeight: 32px
    letterSpacing: -0.02em
  headline-md:
    fontFamily: Inter
    fontSize: 20px
    fontWeight: '600'
    lineHeight: 28px
  body-lg:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  body-md:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 20px
  label-md:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '600'
    lineHeight: 16px
    letterSpacing: 0.05em
  data-mono:
    fontFamily: Inter
    fontSize: 13px
    fontWeight: '500'
    lineHeight: 18px
    letterSpacing: 0.01em
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  unit: 4px
  gutter: 16px
  margin-mobile: 16px
  margin-desktop: 32px
  sidebar-width: 260px
---

## Brand & Style

The brand personality is authoritative, vigilant, and protective. This design system focuses on "Enterprise Security"—a style that prioritizes data density and clarity without sacrificing modern aesthetics. The target audience includes operations managers, HR professionals, and safety officers who require real-time situational awareness.

The visual style is **Corporate / Modern** with a focus on stability. It employs a structured layout to organize complex streams of telemetry data. The emotional response should be one of "controlled oversight"—the user should feel that the system is reliable, the data is accurate, and critical issues will be immediately visible through high-contrast alerts. Whitespace is used strategically to group related data points, while subtle depth helps distinguish between global navigation and active monitoring panels.

## Colors

The palette is anchored by **Deep Navy Blue**, used for core navigation and headers to establish a sense of institutional trust. **Alert Red** is reserved strictly for high-priority safety breaches, SOS signals, and critical geofence exits. **Safety Green** indicates compliance, active check-ins, and safe zones.

For data-rich environments, a range of professional grays is utilized to create hierarchy in tables and logs. 
- Backgrounds use a slightly off-white (#F8FAFC) to reduce eye strain during long shifts.
- Surface containers use pure white (#FFFFFF) to pop against the background.
- Text uses a dark slate (#0F172A) for maximum contrast and legibility.

## Typography

This design system utilizes **Inter** for all roles to ensure maximum legibility across diverse screen resolutions, from high-density desktop dashboards to mobile field devices. 

Headlines use a bold weight and tighter letter spacing to feel "locked-in" and professional. For data logs and coordinate readouts, `data-mono` (Inter with tabular lining figures enabled) should be used to ensure numerical alignment. Labels are frequently uppercased with slight tracking to distinguish them from interactive body text.

## Layout & Spacing

The layout follows a **Fixed Grid** model for dashboard views to maintain consistent data placement. A 12-column grid is used for desktop, while mobile views collapse to a single column with persistent bottom navigation for safety actions.

- **Desktop:** Features a persistent left sidebar (Deep Navy) for global navigation. The main content area uses a "Dashboard" layout with cards arranged in 4-column or 6-column spans.
- **Data Density:** Use a compact 4px base unit. Paddings in tables should be tight (8px-12px) to maximize the "at-a-glance" information density.
- **Maps:** Map views should be edge-to-edge within their containers, with floating control overlays (zoom, layers, legend) positioned with 16px margins from the edges.

## Elevation & Depth

Visual hierarchy is established through **Tonal Layers** supplemented by **Ambient Shadows**. 

- **Level 0 (Background):** Light gray (#F1F5F9) flat surface.
- **Level 1 (Cards/Tables):** White surface with a 1px border (#E2E8F0) and a very soft, diffused shadow (0px 2px 4px rgba(0,0,0,0.05)).
- **Level 2 (Modals/Pop-overs):** White surface with a more pronounced shadow (0px 10px 15px rgba(0,0,0,0.1)) to indicate temporary interaction.
- **Level 3 (Alerts):** Urgent notifications use a subtle outer glow in the alert color (Red or Green) to draw immediate attention without breaking the professional aesthetic.

## Shapes

The design system uses a **Rounded** shape language to balance the "Enterprise Security" seriousness with a modern, approachable feel. 

- **Standard Elements:** Buttons, input fields, and cards utilize a 0.5rem (8px) radius.
- **Large Containers:** Dashboard panels and map overlays utilize a 1rem (16px) radius for a distinct visual "island" effect.
- **Indicators:** Status dots and notification badges are fully pill-shaped.

## Components

### Buttons
Primary buttons use the Deep Navy Blue background with white text. Secondary buttons use a ghost style with a 1px slate border. Destructive actions (e.g., "End Emergency") use the Alert Red solid background.

### Input Fields
Fields feature a subtle 1px border. On focus, the border transitions to Primary Blue with a 2px soft outer glow. Labels are always positioned above the input for clarity in high-density forms.

### Status Chips
Small, high-contrast badges used to indicate GPS signal strength, battery level, or "On-Duty" status. They use a light tint of the status color for the background and a dark shade for the text/icon.

### Data Tables
Rows feature a subtle hover state (#F8FAFC). Headers are sticky and use the `label-md` type style with a light gray bottom border.

### Map Markers
Custom markers are required for employee tracking. These consist of a circular profile image (or initials) with a colored ring indicating status (Green for active/safe, Red for alert, Gray for offline).

### Alerts & Banners
Full-width persistent banners are used for system-wide safety notices. They use highly saturated backgrounds (Red or Yellow) with bold iconography to ensure they are never missed by the operator.
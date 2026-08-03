# Public Health Grant Allocation Model (7-Domain Engine)

An interactive R Shiny decision-support application built for public health intelligence managers, local authority finance officers, and healthcare commissioners. This tool models needs-based Public Health Grant distributions across local authorities—specifically configured for **Lincoln UA** and **Lincolnshire UA**—moving away from historical legacy allocations toward a multi-factor formulaic approach.

---

## 🌟 Key Features

* **7-Domain Needs-Based Allocation Engine:**
  1. **Base Population:** Core headcount demand (ONS 2024 mid-year estimates).
  2. **Deprivation (IMD):** Population-weighted Index of Multiple Deprivation (IMD) scores measuring intensity and volume of poverty/health inequalities.
  3. **0–19 Age Profile:** Statutory early years, health visiting, and school nursing demand.
  4. **65+ & Frailty Index:** Physical activity, fall prevention, and healthy aging demand.
  5. **Wider Determinants:** Housing quality, fuel poverty, and environmental risk factors.
  6. **Sparsity / Rurality:** Geographical dispersion and rural service delivery cost surcharges.
  7. **Coastal / Seasonal Index:** Targeted support for seaside deprivation and seasonal population surges.

* **Pre-Configured Policy Presets:**
  * *Default Baseline Split* (25% Pop, 25% IMD, 10% across remaining domains)
  * *Pure Per Capita (100% Pop)*
  * *Urban Core Focus* (Favours Lincoln UA)
  * *Rural & Coastal Focus* (Favours Lincolnshire UA)
  * *Deprivation & Health Inequalities Focus*
  * *Custom / Manual Weighting* (Enforces a 100% normalized weight constraint with dynamic UI feedback)

* **Transition Smoothing (Floor & Ceiling Damping):**
  * Optional damping cap ($\pm 0	ext{–}100\%$) to cap maximum annual budget shifts relative to baseline historical spending, preventing operational disruption.

* **Detailed Service Budget Breakdown Tab:**
  * Real-time financial breakdown (£) across 12 customizable public health service lines:
    * 0–19 Services (Default: 32.2%)
    * Sexual Health (Default: 20.2%)
    * Staffing and Overheads (Default: 17.1%)
    * Wellbeing Service (Default: 9.6%)
    * Housing Related Support (Default: 6.4%)
    * Integrated Lifestyle Service (Default: 4.0%)
    * CYP Emotional Wellbeing Service (Default: 2.9%)
    * CYP Other (Default: 2.6%)
    * NHS Health Checks (Default: 1.7%)
    * Other Adults Commissioned Services (Default: 1.6%)
    * Public Health Commissioned Services (Default: 1.0%)
    * Public Health Gambling and Oral Health (Default: 0.7%)
  * Interactive inputs with dynamic total validation and a one-click reset to defaults button.

* **Ward-Level Granularity:**
  * Explicit mapping of 30 ward codes to **Lincoln UA**, with remaining wards categorized under **Lincolnshire UA**.
  * Dynamic DataTable tab for viewing and filtering underlying 2024 ward population and health indicator data.
  * Optional CSV file override for custom dataset loading.

---

## 🛠️ Installation & Setup

### Prerequisites
Ensure you have **R** (v4.1.0 or higher) and **RStudio** installed.

### Install Required R Packages
Execute the following command in your R console to install all required dependencies:

```R
install.packages(c("shiny", "bslib", "tidyverse", "DT"))
```

### Running the Application

1. Clone or download this repository:
   ```bash
   git clone https://github.com/your-username/public-health-grant-model.git
   cd public-health-grant-model
   ```

2. Open `app.R` in RStudio or run directly via R:
   ```R
   library(shiny)
   runApp("app.R")
   ```

---

## 📊 Mathematical Architecture

### 1. Unweighted Domain Share
For each authority $\text{UA}$ and domain $j$:
$$\text{share}_{j, \text{UA}} = \frac{\text{Volume}_{j, \text{UA}}}{\sum_{k} \text{Volume}_{j, k}}$$

For IMD (Domain 2), volume is calculated as **Person-Deprivation Units**:
$$\text{Volume}_{\text{IMD, UA}} = \sum_{w \in \text{UA}} (P_w \cdot \text{IMD}_w)$$

### 2. Composite Score & Target Grant
Given normalized policy weights $W_j$ (where $\sum_{j=1}^{7} W_j = 1.0$):
$$\text{Composite Target Share}_{\text{UA}} = \sum_{j=1}^{7} (\text{share}_{j, \text{UA}} \cdot W_j)$$

$$\text{Formula Target Grant}_{\text{UA}} = \text{Composite Target Share}_{\text{UA}} \times \text{Total Grant Pool (£)}$$

### 3. Transition Damping
When enabled, allocations are bounded within a cap $\alpha$ around the scaled baseline $B_{\text{UA}}^{\text{scaled}}$:
$$\text{Min Allowed} = B_{\text{UA}}^{\text{scaled}} \cdot (1 - \alpha), \quad \text{Max Allowed} = B_{\text{UA}}^{\text{scaled}} \cdot (1 + \alpha)$$
Provisional values are then re-scaled to maintain budget neutrality across the total grant pool.

---

## 📂 File Structure

```text
.
├── app.R               # Main R Shiny application (UI, Server, Embedded Data)
├── README.md           # Project documentation and user guide
└── data/               # Optional custom input CSV templates
```

---

## 📜 License

Distributed under the MIT License. See `LICENSE` for more information.

library(shiny)
library(bslib)
library(tidyverse)
library(DT)

# ------------------------------------------------------------------------------
# 0. HARDCODED 2024 LINCOLNSHIRE WARD POPULATION DATA
# ------------------------------------------------------------------------------
embedded_ward_pop_2024 <- 'ward_code,ward_name,total_pop,pop_0_19,pop_65plus,wider_det_score
E05010784,Abbey (Lincoln),11567,2500,1360,9719.5
E05010785,Birchwood (Lincoln),8945,2288,2030,19622.08
E05010786,Boultham,11505,3572,1426,13653.5
E05010787,Carholme,10783,1859,1456,9330.75
E05010788,Castle (Lincoln),7822,1719,1687,14593.12
E05010789,Glebe,8960,2393,1869,19005.58
E05010790,Hartsholme,8192,1667,2497,21260.92
E05010791,Minster,8504,2249,1894,18714.5
E05010792,Moorland,8097,1971,2113,16579.8
E05010793,Park (Lincoln),12874,2620,1304,8249.08
E05010794,Witham (Lincoln),7865,1901,2020,22411.17
E05009621,Coastal (Boston),3853,656,1429,8871.5
E05009622,Fenside,5067,1466,760,13185.17
E05009623,Fishtoft,7535,1813,2291,16693.75
E05009624,Five Village,4019,784,1462,5594
E05009625,Kirton and Frampton,7520,1780,2258,11563
E05009626,Old Leake and Wrangle,3953,701,1284,6208.75
E05009628,Skirbeck,8074,2124,1483,12860.62
E05009627,St Thomas (Boston),2626,675,629,12990
E05009629,Staniland,4247,1038,1249,17692.5
E05009630,Station,2948,777,310,5675.5
E05009631,Swineshead and Holland Fen,4204,880,1382,7954.5
E05009632,Trinity (Boston),5040,1190,1245,11668.83
E05009633,West (Boston),2206,488,657,23282.5
E05009634,Witham (Boston),4699,1171,1005,10405.67
E05009635,Wyberton,5089,1411,1179,14799.5
E05009873,Alford,5095,1040,1870,11160.17
E05009874,Binbrook,2441,320,1114,4922
E05009875,Burgh le Marsh,2837,455,1260,12362.75
E05009876,Chapel St Leonards,4713,536,2617,5508.67
E05009877,Coningsby & Mareham,9776,2057,2669,8615.7
E05009878,Croft (East Lindsey),2497,395,1012,3849.75
E05009879,Friskney,2266,379,880,4064
E05009880,Fulstow,2965,528,1187,0
E05009881,Grimoldby,2413,476,887,11940
E05009882,Hagworthingham,2312,331,983,2149
E05009883,Halton Holegate,2541,341,1194,4627.75
E05009884,Holton-le-Clay & North Thoresby,5106,979,1987,18189.12
E05009885,Horncastle,8151,1580,2753,20309.25
E05009886,Ingoldmells,2281,306,996,5009
E05009887,Legbourne,2130,380,870,6463
E05009888,Mablethorpe,8197,1201,3971,12762.62
E05009889,Marshchapel & Somercotes,4457,684,1904,3139.17
E05009890,North Holme,2946,733,846,25626.75
E05009891,Priory & St James,4874,914,1497,19246.33
E05009892,Roughton (East Lindsey),2359,318,1104,2485.5
E05009897,Scarbrough & Seacroft,9799,2006,3139,18137.83
E05009898,Sibsey & Stickney,5258,871,2075,5458.83
E05009899,Spilsby,3234,762,974,17373.75
E05009893,St Clements (East Lindsey),5662,1175,1944,20397
E05009894,St Margarets (East Lindsey),3023,682,846,25398.5
E05009895,St Marys (East Lindsey),2320,361,1026,22339.5
E05009896,St Michaels (East Lindsey),2433,497,911,24563.25
E05009900,Sutton on Sea,4301,440,2916,16640.25
E05009901,Tetford & Donington,2477,355,1123,2633.5
E05009902,Tetney,2780,562,941,9389.75
E05009903,Trinity (East Lindsey),2556,595,586,23528
E05009904,Wainfleet,2767,541,1036,2947.75
E05009905,Willoughby with Sloothby,2451,283,1151,2033.5
E05009906,Winthorpe,6075,1082,2040,15905.17
E05009907,Withern & Theddlethorpe,2554,299,1291,1265.5
E05009908,Woodhall Spa,4431,665,2205,17205.83
E05009909,Wragby,2705,514,952,3086
E05009636,Bardney,2846,621,905,8868
E05009637,Caistor and Yarborough,5774,1086,2090,12289.83
E05009638,Cherry Willingham,8578,1800,2736,16386.25
E05009639,Dunholme and Welton,9332,2131,2798,15737.12
E05009640,Gainsborough East,7562,2124,1583,20887.12
E05009641,Gainsborough North,7898,1944,1728,15228.12
E05009642,Gainsborough South-West,6013,1313,1237,9330
E05009643,Hemswell,2622,423,824,3359.25
E05009644,Kelsey Wold,2721,461,1020,5382.5
E05009645,Lea,2262,351,957,11583
E05009646,Market Rasen,8757,1600,3151,11632.62
E05009647,Nettleham,4643,847,1827,21520.17
E05009648,Saxilby,6164,1084,2218,15519
E05009649,Scampton,2799,632,654,10909.5
E05009650,Scotter and Blyton,7586,1402,2617,11431.3
E05009651,Stow (West Lindsey),2614,485,966,11665.5
E05009652,Sudbrooke,2923,664,948,18409.5
E05009653,Torksey,2941,389,1460,1093.25
E05009654,Waddingham and Spital,2435,397,886,4296
E05009655,Wold View,2738,562,942,4851.5
E05010148,Aveland,2453,471,964,3569
E05010149,Belmont (South Kesteven),4742,1008,1316,21367.33
E05010150,Belvoir,5307,1013,2049,9462.17
E05010151,Bourne Austerby,9636,2728,1473,27452.9
E05010152,Bourne East,4855,928,1756,23065.67
E05010153,Bourne West,5010,984,1828,26429.75
E05010154,Casewick,5823,1043,2201,15840.5
E05010155,Castle (South Kesteven),2387,433,955,2875
E05010156,Deeping St James,7644,1663,2247,22015.8
E05010157,Dole Wood,2448,500,855,17418.5
E05010158,Glen (South Kesteven),2353,502,747,4358.75
E05010159,Grantham Arnoldfield,5732,1296,1402,24678.25
E05010160,Grantham Barrowby Gate,4785,894,1662,26511.25
E05010161,Grantham Earlesfield,6687,2062,983,25256.38
E05010162,Grantham Harrowby,4889,1275,1170,25695.5
E05010165,Grantham Springfield,5725,1450,995,20761
E05010163,Grantham St Vincents,7677,1641,1840,21905.88
E05010164,Grantham St Wulframs,5582,1012,1846,23502.88
E05010166,Isaac Newton,4818,914,1458,10019.75
E05010167,Lincrest,2567,441,1018,2043.5
E05010168,Loveden Heath,2538,446,987,4900.5
E05010169,Market & West Deeping,7307,1573,2463,23694.12
E05010170,Morton (South Kesteven),2471,528,668,11435.5
E05010171,Peascliffe & Ridgeway,5049,1029,1733,11539.83
E05010172,Stamford All Saints,4881,1079,1344,23255.75
E05010173,Stamford St Georges,5152,1054,1395,23468.75
E05010174,Stamford St Johns,5864,1380,1518,22100
E05010175,Stamford St Marys,5040,912,1786,19589.5
E05010176,Toller (South Kesteven),2652,526,888,3195.5
E05010177,Viking (South Kesteven),5077,947,1894,10243.25
E05005644,Crowland and Deeping St Nicholas,7689,1858,1831,9618.33
E05005645,"Donington, Quadring and Gosberton",7700,1588,2717,11726
E05005646,Fleet,2630,456,985,10182
E05005647,Gedney,2324,474,853,5006
E05005648,Holbeach Hurn,2393,433,743,5355
E05005649,Holbeach Town,8641,1823,2650,19505.12
E05005650,Long Sutton,7781,1516,3049,12335.38
E05005651,"Moulton, Weston and Cowbit",7781,1575,2416,11563.25
E05005652,Pinchbeck and Surfleet,7930,1684,2509,11393.25
E05005653,Spalding Castle,2692,479,764,18755.25
E05005654,Spalding Monks House,5921,1318,1441,21384.62
E05005655,Spalding St Johns,6759,1466,1450,19575.5
E05005656,Spalding St Marys,4812,1051,1430,17763.67
E05005657,Spalding St Pauls,5774,1340,1440,15727.33
E05005658,Spalding Wygate,6694,1672,1434,25668.17
E05005659,Sutton Bridge,4503,987,1299,10407.17
E05005660,The Saints,2826,562,906,5801
E05005661,Whaplode and Holbeach St Johns,4448,716,1607,7810.17
E05014425,"Ashby de la Launde, Digby & Scopwick",2749,536,652,6474.75
E05014426,Bassingham Rural,2522,492,813,7260
E05014427,Billinghay Rural,5557,1075,1886,3483.83
E05014428,Bracebridge Heath,5815,1170,1491,22847.67
E05014429,Branston (North Kesteven),5831,1236,1853,18436.67
E05014430,"Cranwell, Leasingham & Wilsford",5809,1102,1646,14611
E05014431,Heckington Rural,5090,855,2120,14192.33
E05014432,Heighington & Washingborough,7379,1394,2643,19823.88
E05014433,Helpringham & Osbournby,2916,463,1108,2629.5
E05014434,Hykeham Central,7708,1236,3234,28206.5
E05014435,Hykeham Fosse,6938,1879,892,23828.5
E05014436,Hykeham Memorial,3398,772,831,25191.75
E05014437,Kirkby la Thorpe & South Kyme,2415,416,921,11662
E05014438,Metheringham Rural,5580,1147,1826,13829
E05014439,Navenby & Brant Broughton,5830,1017,2262,8966.33
E05014440,Ruskington,5726,1019,2054,19786
E05014441,Skellingthorpe & Eagle,5548,1000,1898,15488.83
E05014442,Sleaford Castle,2837,685,513,24457.5
E05014443,Sleaford Holdingham,3578,1044,653,25783.25
E05014444,Sleaford Navigation,3037,554,982,25099.5
E05014445,Sleaford Quarrington & Mareham,8492,1981,1933,25609.38
E05014446,Sleaford Westholme,2832,587,809,22937.25
E05014447,Waddington Rural,8763,1938,2116,21320
E05014448,Witham St Hughs & Swinderby,6118,1655,905,15461.67
'

# Default Service Percentages List
default_service_splits <- list(
  srv_019           = 32.2,
  srv_sexhealth     = 20.2,
  srv_staffing      = 17.1,
  srv_wellbeing     = 9.6,
  srv_housing       = 6.4,
  srv_lifestyle     = 4.0,
  srv_cyp_ewb       = 2.9,
  srv_cyp_other     = 2.6,
  srv_healthchecks  = 1.7,
  srv_adult_comm    = 1.6,
  srv_ph_comm       = 1.0,
  srv_gambling_oral = 0.7
)

# ------------------------------------------------------------------------------
# 1. SHINY UI
# ------------------------------------------------------------------------------
ui <- page_sidebar(
  theme = bs_theme(bootswatch = "zephyr", primary = "#1F4E79"),
  title = "Public Health Grant Allocation Model (7-Domain Engine)",
  
  sidebar = sidebar(
    width = 360,
    title = "Model Parameters",
    
    p(strong("Data Source: "), "Embedded 2024 Lincolnshire Ward Population", class = "small text-muted mb-2"),
    
    fileInput("upload_override", "Override with Custom CSV (Optional)", 
              accept = c(".csv"),
              buttonLabel = "Browse...",
              placeholder = "Using embedded 2024 data..."),
    hr(),
    
    numericInput("total_grant", "Total Public Health Grant (£)", value = 35000000, step = 500000),
    hr(),
    
    selectInput("preset", "Preset Weighting Scenarios:",
                choices = c(
                  "Custom / Manual" = "custom",
                  "Default Baseline Split" = "default",
                  "Pure Per Capita (100% Pop)" = "pop_only",
                  "Urban Core Focus (Favours Lincoln UA)" = "urban_fav",
                  "Rural & Coastal Focus (Favours Lincolnshire UA)" = "rural_fav",
                  "Deprivation & Health Inequalities" = "deprivation_fav"
                ),
                selected = "default"),
    
    h5("Domain Weights (%)"),
    uiOutput("weight_total_status"),
    
    sliderInput("w_pop", "1. Base Population", min = 0, max = 100, value = 25, step = 5, post = "%"),
    sliderInput("w_imd", "2. Deprivation (IMD)", min = 0, max = 100, value = 25, step = 5, post = "%"),
    sliderInput("w_age", "3. 0-19 Age Profile", min = 0, max = 100, value = 10, step = 5, post = "%"),
    sliderInput("w_65plus", "4. 65+ & Frailty Index", min = 0, max = 100, value = 10, step = 5, post = "%"),
    sliderInput("w_wider", "5. Wider Determinants (Housing/Fuel)", min = 0, max = 100, value = 10, step = 5, post = "%"),
    sliderInput("w_sparse", "6. Sparsity / Rurality", min = 0, max = 100, value = 10, step = 5, post = "%"),
    sliderInput("w_coastal", "7. Coastal / Seasonal", min = 0, max = 100, value = 10, step = 5, post = "%"),
    
    hr(),
    h5("Transition Smoothing"),
    checkboxInput("show_damped", "Apply & Show Damped Values", value = FALSE),
    conditionalPanel(
      condition = "input.show_damped == true",
      sliderInput("damping_cap", "Max Change vs Baseline Spend (%)", min = 0, max = 100, value = 10, step = 5, post = "%")
    )
  ),
  
  layout_columns(
    fill = FALSE,
    uiOutput("vbox_total"),
    uiOutput("vbox_urban"),
    uiOutput("vbox_rural")
  ),
  
  navset_card_tab(
    nav_panel("Allocation Summary", 
              card(
                card_header("Summary Table"),
                card_body(tableOutput("summary_table"))
              ),
              card(
                card_header("Grant Realignment vs Baseline Spend"),
                card_body(plotOutput("comparison_plot", height = "300px"))
              )
    ),
    nav_panel("Domain Share Analysis",
              card(
                card_header("Authority Share Comparison by Domain Factor"),
                card_body(
                  p("This table displays the unweighted share each authority holds across all 7 domain indicators.", class = "text-muted small"),
                  tableOutput("domain_share_table")
                )
              )
    ),
    nav_panel("Budget Breakdown",
              layout_sidebar(
                sidebar = sidebar(
                  width = 340,
                  title = "Service Budget Splits (%)",
                  p("Adjust service area percentages below. Defaults sum to 100%.", class = "small text-muted mb-2"),
                  uiOutput("service_total_status"),
                  numericInput("srv_019", "0-19 Services", value = 32.2, min = 0, max = 100, step = 0.1),
                  numericInput("srv_sexhealth", "Sexual Health", value = 20.2, min = 0, max = 100, step = 0.1),
                  numericInput("srv_staffing", "Staffing and Overheads", value = 17.1, min = 0, max = 100, step = 0.1),
                  numericInput("srv_wellbeing", "Wellbeing Service", value = 9.6, min = 0, max = 100, step = 0.1),
                  numericInput("srv_housing", "Housing related support", value = 6.4, min = 0, max = 100, step = 0.1),
                  numericInput("srv_lifestyle", "Integrated Lifestyle Service", value = 4.0, min = 0, max = 100, step = 0.1),
                  numericInput("srv_cyp_ewb", "CYP Emotional Wellbeing Service", value = 2.9, min = 0, max = 100, step = 0.1),
                  numericInput("srv_cyp_other", "CYP other", value = 2.6, min = 0, max = 100, step = 0.1),
                  numericInput("srv_healthchecks", "NHS Health Checks", value = 1.7, min = 0, max = 100, step = 0.1),
                  numericInput("srv_adult_comm", "Other Adults Commissioned Services", value = 1.6, min = 0, max = 100, step = 0.1),
                  numericInput("srv_ph_comm", "Public Health Commissioned Services", value = 1.0, min = 0, max = 100, step = 0.1),
                  numericInput("srv_gambling_oral", "Public Health Gambling and Oral Health", value = 0.7, min = 0, max = 100, step = 0.1),
                  actionButton("reset_srv_defaults", "Reset to Default Splits", class = "btn-outline-secondary btn-sm w-100 mt-2")
                ),
                card(
                  card_header("Target Area Service Budget Breakdown (£)"),
                  card_body(tableOutput("service_breakdown_table"))
                )
              )
    ),
    nav_panel("Ward-Level Data", 
              card(
                card_header("Source 2024 Ward Population & Health Indicator Data"),
                card_body(DTOutput("ward_table"))
              )
    )
  )
)

# ------------------------------------------------------------------------------
# 2. SHINY SERVER
# ------------------------------------------------------------------------------
server <- function(input, output, session) {
  
  # PRESET OBSERVER
  observeEvent(input$preset, {
    req(input$preset)
    
    weights <- switch(input$preset,
                      "default"         = list(pop=25, imd=25, age=10, c65=10, wider=10, sparse=10, coastal=10),
                      "pop_only"        = list(pop=100, imd=0, age=0, c65=0, wider=0, sparse=0, coastal=0),
                      "urban_fav"       = list(pop=20, imd=40, age=15, c65=0, wider=25, sparse=0, coastal=0),
                      "rural_fav"       = list(pop=20, imd=0, age=0, c65=20, wider=0, sparse=35, coastal=25),
                      "deprivation_fav" = list(pop=10, imd=50, age=10, c65=0, wider=30, sparse=0, coastal=0),
                      NULL
    )
    
    if (!is.null(weights)) {
      updateSliderInput(session, "w_pop", value = weights$pop)
      updateSliderInput(session, "w_imd", value = weights$imd)
      updateSliderInput(session, "w_age", value = weights$age)
      updateSliderInput(session, "w_65plus", value = weights$c65)
      updateSliderInput(session, "w_wider", value = weights$wider)
      updateSliderInput(session, "w_sparse", value = weights$sparse)
      updateSliderInput(session, "w_coastal", value = weights$coastal)
    }
  }, ignoreInit = TRUE)
  
  # RESET SERVICE DEFAULTS OBSERVER
  observeEvent(input$reset_srv_defaults, {
    for (name in names(default_service_splits)) {
      updateNumericInput(session, name, value = default_service_splits[[name]])
    }
  })
  
  # UI CONSTRAINT: Enforce 100% total limit across 7 sliders in 5% increments
  enforce_weights <- function(changed_slider, val) {
    isolate({
      weights <- list(
        w_pop = input$w_pop,
        w_imd = input$w_imd,
        w_age = input$w_age,
        w_65plus = input$w_65plus,
        w_wider = input$w_wider,
        w_sparse = input$w_sparse,
        w_coastal = input$w_coastal
      )
      other_sum <- sum(unlist(weights[names(weights) != changed_slider]))
      if (val + other_sum > 100) {
        max_allowed <- floor((100 - other_sum) / 5) * 5
        updateSliderInput(session, changed_slider, value = max(0, max_allowed))
      }
      if (input$preset != "custom") {
        updateSelectInput(session, "preset", selected = "custom")
      }
    })
  }
  
  observeEvent(input$w_pop, { enforce_weights("w_pop", input$w_pop) }, ignoreInit = TRUE)
  observeEvent(input$w_imd, { enforce_weights("w_imd", input$w_imd) }, ignoreInit = TRUE)
  observeEvent(input$w_age, { enforce_weights("w_age", input$w_age) }, ignoreInit = TRUE)
  observeEvent(input$w_65plus, { enforce_weights("w_65plus", input$w_65plus) }, ignoreInit = TRUE)
  observeEvent(input$w_wider, { enforce_weights("w_wider", input$w_wider) }, ignoreInit = TRUE)
  observeEvent(input$w_sparse, { enforce_weights("w_sparse", input$w_sparse) }, ignoreInit = TRUE)
  observeEvent(input$w_coastal, { enforce_weights("w_coastal", input$w_coastal) }, ignoreInit = TRUE)
  
  # Dynamic status banner for domain weights
  output$weight_total_status <- renderUI({
    tot <- sum(c(
      input$w_pop, input$w_imd, input$w_age, input$w_65plus, 
      input$w_wider, input$w_sparse, input$w_coastal
    ))
    unallocated <- 100 - tot
    
    if (tot == 100) {
      HTML(paste0(
        '<div class="alert alert-success py-2 px-3 mb-3 small">',
        '<strong>Total: 100%</strong> (Fully Allocated)<br>',
        '<span class="text-muted" style="font-size: 0.8em;">Lower a slider first to increase another.</span>',
        '</div>'
      ))
    } else {
      HTML(paste0(
        '<div class="alert alert-warning py-2 px-3 mb-3 small">',
        '<strong>Total: ', tot, '%</strong> (', unallocated, '% Unallocated)',
        '</div>'
      ))
    }
  })
  
  # Dynamic status banner for service budget splits
  output$service_total_status <- renderUI({
    srv_tot <- sum(c(
      req(input$srv_019), req(input$srv_sexhealth), req(input$srv_staffing),
      req(input$srv_wellbeing), req(input$srv_housing), req(input$srv_lifestyle),
      req(input$srv_cyp_ewb), req(input$srv_cyp_other), req(input$srv_healthchecks),
      req(input$srv_adult_comm), req(input$srv_ph_comm), req(input$srv_gambling_oral)
    ))
    
    if (abs(srv_tot - 100) < 0.01) {
      HTML('<div class="alert alert-success py-1 px-2 mb-2 small"><strong>Service Total: 100.0%</strong></div>')
    } else {
      HTML(paste0('<div class="alert alert-warning py-1 px-2 mb-2 small"><strong>Service Total: ', sprintf("%.1f%%", srv_tot), '</strong> (Target: 100%)</div>'))
    }
  })
  
  # DATA PIPELINE: Load hardcoded 2024 CSV text string
  ward_data_raw <- reactive({
    
    lincoln_ua_codes <- c(
      "E05009636", "E05009638", "E05009639", "E05009647", "E05009648", 
      "E05009649", "E05009652", "E05010784", "E05010785", "E05010786", 
      "E05010787", "E05010788", "E05010789", "E05010790", "E05010791", 
      "E05010792", "E05010793", "E05010794", "E05014426", "E05014428", 
      "E05014429", "E05014432", "E05014434", "E05014435", "E05014436", 
      "E05014438", "E05014439", "E05014441", "E05014447", "E05014448"
    )
    
    if (!is.null(input$upload_override)) {
      df <- read_csv(input$upload_override$datapath, show_col_types = FALSE)
    } else {
      df <- read_csv(I(embedded_ward_pop_2024), show_col_types = FALSE)
    }
    
    if (!"pop_65plus" %in% names(df)) df$pop_65plus <- round(df$total_pop * 0.22)
    if (!"wider_det_score" %in% names(df)) df$wider_det_score <- 25.0
    
    df <- df %>%
      mutate(
        unitary_authority = if_else(
          ward_code %in% lincoln_ua_codes, 
          "Lincoln UA", 
          "Lincolnshire UA"
        )
      )
    
    df <- tryCatch({
      imd_data <- suppressWarnings(read_csv("https://raw.githubusercontent.com/humaniverse/IMD/main/data-raw/imd_england_ward.csv", show_col_types = FALSE)) %>%
        select(ward_code, imd_score)
      
      df %>%
        left_join(imd_data, by = "ward_code") %>%
        mutate(imd_score = coalesce(imd_score, if_else(unitary_authority == "Lincoln UA", 32.5, 20.1)))
    }, error = function(e) {
      df %>% mutate(imd_score = if_else(unitary_authority == "Lincoln UA", 32.5, 20.1))
    })
    
    df <- df %>%
      mutate(
        sparsity_score = if_else(unitary_authority == "Lincoln UA", 0.05, 1.2),
        coastal_index = if_else(str_detect(ward_name, "(?i)Skegness|Mablethorpe|Ingoldmells|Boston|Wainfleet"), 1.0, 0.0),
        historical_spend = total_pop
      )
    
    return(df)
  })
  
  # Aggregation to Unitary Authorities across 7 domain shares
  ua_aggregated <- reactive({
    req(ward_data_raw())
    
    ua <- ward_data_raw() %>%
      group_by(unitary_authority) %>%
      summarise(
        total_pop = sum(total_pop, na.rm = TRUE),
        weighted_imd = sum(imd_score * total_pop, na.rm = TRUE) / sum(total_pop, na.rm = TRUE),
        total_pop_0_19 = sum(pop_0_19, na.rm = TRUE),
        total_pop_65plus = sum(pop_65plus, na.rm = TRUE),
        weighted_wider = sum(wider_det_score * total_pop, na.rm = TRUE) / sum(total_pop, na.rm = TRUE),
        total_sparsity = sum(sparsity_score * total_pop, na.rm = TRUE),
        total_coastal = sum(coastal_index * total_pop, na.rm = TRUE),
        historical_spend = sum(historical_spend, na.rm = TRUE),
        .groups = "drop"
      )
    
    tot_pop <- sum(ua$total_pop)
    tot_imd <- sum(ua$weighted_imd * ua$total_pop)
    tot_age <- sum(ua$total_pop_0_19)
    tot_65 <- sum(ua$total_pop_65plus)
    tot_wider <- sum(ua$weighted_wider * ua$total_pop)
    tot_sparse <- sum(ua$total_sparsity)
    tot_coastal <- sum(ua$total_coastal)
    
    ua %>%
      mutate(
        share_pop = total_pop / tot_pop,
        share_imd = (weighted_imd * total_pop) / tot_imd,
        share_age = total_pop_0_19 / tot_age,
        share_65plus = total_pop_65plus / tot_65,
        share_wider = (weighted_wider * total_pop) / tot_wider,
        share_sparse = total_sparsity / ifelse(tot_sparse == 0, 1, tot_sparse),
        share_coastal = total_coastal / ifelse(tot_coastal == 0, 1, tot_coastal)
      )
  })
  
  # Calculation engine
  model_results <- reactive({
    req(ua_aggregated())
    
    raw_weights <- c(
      input$w_pop, input$w_imd, input$w_age, input$w_65plus, 
      input$w_wider, input$w_sparse, input$w_coastal
    )
    tot_w <- sum(raw_weights)
    w <- if(tot_w == 0) rep(1/7, 7) else raw_weights / tot_w
    
    ua_calc <- ua_aggregated() %>%
      mutate(
        scaled_historical_spend = (historical_spend / sum(historical_spend)) * input$total_grant
      )
    
    ua_calc <- ua_calc %>%
      mutate(
        composite_score = (share_pop * w[1]) + 
          (share_imd * w[2]) + 
          (share_age * w[3]) + 
          (share_65plus * w[4]) + 
          (share_wider * w[5]) + 
          (share_sparse * w[6]) + 
          (share_coastal * w[7]),
        raw_target_grant = composite_score * input$total_grant
      )
    
    total_raw_target <- sum(ua_calc$raw_target_grant)
    
    ua_calc <- ua_calc %>%
      mutate(
        target_grant = (raw_target_grant / total_raw_target) * input$total_grant
      )
    
    ua_calc <- ua_calc %>%
      mutate(
        max_allowed = scaled_historical_spend * (1 + input$damping_cap / 100),
        min_allowed = scaled_historical_spend * (1 - input$damping_cap / 100),
        prov_damped_grant = pmin(pmax(target_grant, min_allowed), max_allowed)
      )
    
    total_prov <- sum(ua_calc$prov_damped_grant)
    
    ua_calc %>%
      mutate(
        damped_grant = (prov_damped_grant / total_prov) * input$total_grant,
        historical_spend = scaled_historical_spend
      )
  })
  
  # Reactive calculations for Service Budget Breakdown
  service_splits_df <- reactive({
    req(model_results())
    
    res <- model_results()
    
    lincoln_grant <- res %>% filter(unitary_authority == "Lincoln UA") %>% pull(if(input$show_damped) damped_grant else target_grant)
    lincs_grant   <- res %>% filter(unitary_authority == "Lincolnshire UA") %>% pull(if(input$show_damped) damped_grant else target_grant)
    
    if(length(lincoln_grant) == 0) lincoln_grant <- 0
    if(length(lincs_grant) == 0) lincs_grant <- 0
    
    tibble(
      `Public Health Service Area` = c(
        "0-19 Services",
        "Sexual Health",
        "Staffing and Overheads",
        "Wellbeing Service",
        "Housing related support",
        "Integrated Lifestyle Service",
        "CYP Emotional Wellbeing Service",
        "CYP other",
        "NHS Health Checks",
        "Other Adults Commissioned Services",
        "Public Health Commissioned Services",
        "Public Health Gambling and Oral Health"
      ),
      `Allocation (%)` = c(
        req(input$srv_019),
        req(input$srv_sexhealth),
        req(input$srv_staffing),
        req(input$srv_wellbeing),
        req(input$srv_housing),
        req(input$srv_lifestyle),
        req(input$srv_cyp_ewb),
        req(input$srv_cyp_other),
        req(input$srv_healthchecks),
        req(input$srv_adult_comm),
        req(input$srv_ph_comm),
        req(input$srv_gambling_oral)
      )
    ) %>%
      mutate(
        `Lincoln UA (£)` = lincoln_grant * (`Allocation (%)` / 100),
        `Lincolnshire UA (£)` = lincs_grant * (`Allocation (%)` / 100),
        `Total County (£)` = `Lincoln UA (£)` + `Lincolnshire UA (£)`
      )
  })
  
  output$vbox_total <- renderUI({
    value_box(
      title = "Total Public Health Grant Pool",
      value = paste0("£", formatC(round(input$total_grant), format = "d", big.mark = ",")),
      p("100.0% Countywide Funding Pool", class = "small mb-0", style = "color: rgba(255, 255, 255, 0.85);"),
      showcase = icon("coins"),
      theme = "primary",
      height = "140px"
    )
  })
  
  output$vbox_urban <- renderUI({
    req(model_results())
    res <- model_results() %>% filter(unitary_authority == "Lincoln UA")
    if(nrow(res) == 0) return(value_box("Lincoln UA Share", "Calculating...", showcase = icon("building"), height = "140px"))
    
    display_val <- if(input$show_damped) res$damped_grant else res$target_grant
    title_text <- if(input$show_damped) "Lincoln UA (Damped)" else "Lincoln UA (Target)"
    
    val_text <- paste0("£", formatC(round(display_val), format = "d", big.mark = ","))
    sub_text <- paste0(sprintf("%.1f%%", display_val / input$total_grant * 100), " of Total Pool")
    
    value_box(
      title = title_text,
      value = val_text,
      p(sub_text, style = "font-size: 1.2rem; font-weight: 600; color: #FFFFFF; margin-bottom: 0;"),
      showcase = icon("building"),
      theme = "info",
      height = "140px"
    )
  })
  
  output$vbox_rural <- renderUI({
    req(model_results())
    res <- model_results() %>% filter(unitary_authority == "Lincolnshire UA")
    if(nrow(res) == 0) return(value_box("Lincolnshire UA Share", "Calculating...", showcase = icon("tree"), height = "140px"))
    
    display_val <- if(input$show_damped) res$damped_grant else res$target_grant
    title_text <- if(input$show_damped) "Lincolnshire UA (Damped)" else "Lincolnshire UA (Target)"
    
    val_text <- paste0("£", formatC(round(display_val), format = "d", big.mark = ","))
    sub_text <- paste0(sprintf("%.1f%%", display_val / input$total_grant * 100), " of Total Pool")
    
    value_box(
      title = title_text,
      value = val_text,
      p(sub_text, style = "font-size: 1.2rem; font-weight: 600; color: #FFFFFF; margin-bottom: 0;"),
      showcase = icon("tree"),
      theme = "success",
      height = "140px"
    )
  })
  
  output$summary_table <- renderTable({
    res <- model_results() %>%
      mutate(
        target_shift = ((target_grant - historical_spend) / historical_spend) * 100,
        damped_shift = ((damped_grant - historical_spend) / historical_spend) * 100,
        target_per_head = target_grant / total_pop 
      )
    
    if (input$show_damped) {
      tab <- res %>% select(
        `Unitary Authority` = unitary_authority,
        `Projected Population` = total_pop,
        `Scaled Baseline (£)` = historical_spend,
        `Formula Target (£)` = target_grant,
        `Target Per Head (£)` = target_per_head,
        `Damped Grant (£)` = damped_grant,
        `Shift vs Baseline (%)` = damped_shift
      )
    } else {
      tab <- res %>% select(
        `Unitary Authority` = unitary_authority,
        `Projected Population` = total_pop,
        `Scaled Baseline (£)` = historical_spend,
        `Formula Target (£)` = target_grant,
        `Target Per Head (£)` = target_per_head,
        `Target Shift vs Baseline (%)` = target_shift
      )
    }
    
    tab %>%
      mutate(
        `Projected Population` = formatC(round(`Projected Population`), format = "d", big.mark = ","),
        `Scaled Baseline (£)` = paste0("£", formatC(round(`Scaled Baseline (£)`), format = "d", big.mark = ",")),
        `Formula Target (£)` = paste0("£", formatC(round(`Formula Target (£)`), format = "d", big.mark = ",")),
        `Target Per Head (£)` = paste0("£", sprintf("%.2f", `Target Per Head (£)`))
      ) %>%
      {if("Damped Grant (£)" %in% names(.)) mutate(., `Damped Grant (£)` = paste0("£", formatC(round(`Damped Grant (£)`), format = "d", big.mark = ","))) else .} %>%
      {if("Shift vs Baseline (%)" %in% names(.)) mutate(., `Shift vs Baseline (%)` = sprintf("%+.1f%%", `Shift vs Baseline (%)`)) else .} %>%
      {if("Target Shift vs Baseline (%)" %in% names(.)) mutate(., `Target Shift vs Baseline (%)` = sprintf("%+.1f%%", `Target Shift vs Baseline (%)`)) else .}
    
  }, striped = TRUE, hover = TRUE, bordered = TRUE)
  
  output$domain_share_table <- renderTable({
    req(ua_aggregated())
    ua_aggregated() %>%
      select(
        `Unitary Authority` = unitary_authority,
        `1. Base Pop Share` = share_pop,
        `2. Deprivation (IMD) Share` = share_imd,
        `3. 0-19 Age Share` = share_age,
        `4. 65+ Frailty Share` = share_65plus,
        `5. Wider Det Share` = share_wider,
        `6. Sparsity Share` = share_sparse,
        `7. Coastal Share` = share_coastal
      ) %>%
      mutate(across(where(is.numeric), ~ sprintf("%.2f%%", .x * 100)))
  }, striped = TRUE, hover = TRUE, bordered = TRUE)
  
  output$service_breakdown_table <- renderTable({
    req(service_splits_df())
    
    df <- service_splits_df()
    
    totals_row <- tibble(
      `Public Health Service Area` = "TOTAL ALLOCATED BUDGET",
      `Allocation (%)` = sum(df$`Allocation (%)`),
      `Lincoln UA (£)` = sum(df$`Lincoln UA (£)`),
      `Lincolnshire UA (£)` = sum(df$`Lincolnshire UA (£)`),
      `Total County (£)` = sum(df$`Total County (£)`)
    )
    
    bind_rows(df, totals_row) %>%
      mutate(
        `Allocation (%)` = sprintf("%.1f%%", `Allocation (%)`),
        `Lincoln UA (£)` = paste0("£", formatC(round(`Lincoln UA (£)`), format = "d", big.mark = ",")),
        `Lincolnshire UA (£)` = paste0("£", formatC(round(`Lincolnshire UA (£)`), format = "d", big.mark = ",")),
        `Total County (£)` = paste0("£", formatC(round(`Total County (£)`), format = "d", big.mark = ","))
      )
  }, striped = TRUE, hover = TRUE, bordered = TRUE)
  
  output$comparison_plot <- renderPlot({
    plot_data <- model_results() %>%
      select(unitary_authority, Baseline = historical_spend, `Target Formula` = target_grant, Damped = damped_grant) %>%
      pivot_longer(cols = -unitary_authority, names_to = "Allocation_Type", values_to = "Amount")
    
    if (!input$show_damped) {
      plot_data <- plot_data %>% filter(Allocation_Type != "Damped")
    }
    
    ggplot(plot_data, aes(x = unitary_authority, y = Amount / 1e6, fill = Allocation_Type)) +
      geom_col(position = "dodge") +
      scale_fill_manual(values = c("Baseline" = "#999999", "Target Formula" = "#1F4E79", "Damped" = "#2E8B57")) +
      labs(y = "Grant Allocation (£ Millions)", x = NULL, fill = "Allocation Engine") +
      theme_minimal(base_size = 14) +
      theme(legend.position = "bottom")
  })
  
  output$ward_table <- renderDT({
    req(ward_data_raw())
    datatable(ward_data_raw(), options = list(pageLength = 10, scrollX = TRUE), rownames = FALSE)
  })
}

shinyApp(ui = ui, server = server)
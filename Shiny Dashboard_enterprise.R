library(shiny)
library(bslib)

# ========================== UI ==========================

ui <- navbarPage(
  
  title = div(
    div("REMOTE AUDIT ANALYTICS DASHBOARD",
        style="
        font-weight:900;
        font-size:26px;
        letter-spacing:2px;
        color:#ffffff;
        "),
    div("Remote Audit & Risk Monitoring System",
        style="
        font-size:13px;
        color:#FFD700;
        letter-spacing:1px;
        margin-top:2px;
        "),
    style="
    padding:8px 20px;
    border-left:5px solid #FFD700;
    "
  ),
  
  theme = bs_theme(
    version = 5,
    primary = "#0b3d91",
    base_font = font_google("Roboto")
  ),
  
  header = tags$style(HTML("
    
    /* ===== ENTERPRISE NAVBAR ===== */
    .navbar {
      background: linear-gradient(90deg, #0f2027, #1c3b70, #0b3d91) !important;
      box-shadow: 0 6px 18px rgba(0,0,0,0.45);
      padding-top: 12px;
      padding-bottom: 12px;
      position: relative;
    }
    
    .navbar::after {
      content: '';
      display: block;
      height: 4px;
      background: linear-gradient(90deg, #FFD700, #ffb300);
      position: absolute;
      bottom: 0;
      left: 0;
      right: 0;
    }
    
    .navbar .nav-link {
      color: #f1f1f1 !important;
      font-weight: 600;
      font-size: 15px;
      margin-right: 12px;
      transition: 0.3s;
    }
    
    .navbar .nav-link:hover {
      color: #FFD700 !important;
      transform: translateY(-2px);
    }
    
    body {
      background-color: #f4f6f9;
    }
    
    .card-core {
      background-color: #edf7ed;
      border-left: 6px solid #1b5e20;
      padding: 18px;
      border-radius: 10px;
      box-shadow: 0 4px 12px rgba(0,0,0,0.08);
      transition: 0.3s;
    }
    
    .card-core:hover {
      transform: translateY(-3px);
      box-shadow: 0 8px 20px rgba(0,0,0,0.12);
    }
    
    .card-other {
      background-color: #eef4fb;
      border-left: 6px solid #0d47a1;
      padding: 18px;
      border-radius: 10px;
      box-shadow: 0 4px 12px rgba(0,0,0,0.08);
      transition: 0.3s;
    }
    
    .card-other:hover {
      transform: translateY(-3px);
      box-shadow: 0 8px 20px rgba(0,0,0,0.12);
    }
    
    .btn-custom {
      margin-bottom: 12px;
      width: 100%;
      font-weight: 600;
      border-radius: 6px;
      letter-spacing: 0.5px;
    }
    
    h4 {
      font-weight: 700;
      margin-bottom: 15px;
    }
    
  ")),
  
  # ========================== TABS ==========================
  
  tabPanel("Audit Planning",
           br(),
           div(class="card-core",
               h4("Core Planning"),
               actionButton("plan", "Annual Audit Plan",
                            class="btn btn-success btn-custom"),
               actionButton("risk", "Individual Unit Plan",
                            class="btn btn-success btn-custom")
           )
  ),
  
  tabPanel("Audit Sampling",
           br(),
           fluidRow(
             column(6,
                    div(class="card-core",
                        h4("Core Modules"),
                        actionButton("voucher", "Voucher Sampling",
                                     class="btn btn-success btn-custom"),
                        actionButton("tender", "Tender Sampling",
                                     class="btn btn-success btn-custom"),
                        actionButton("contract_sample", "Completed Contract Sampling",
                                     class="btn btn-success btn-custom"),
                        actionButton("JV", "Journal Voucher Sampling",
                                     class="btn btn-success btn-custom")
                    )
             ),
             column(6,
                    div(class="card-other",
                        h4("Other Modules"),
                        actionButton("pension_sample", "Pension Sampling",
                                     class="btn btn-primary btn-custom"),
                        actionButton("DCRG_sample", "DCRG Sampling",
                                     class="btn btn-primary btn-custom"),
                        actionButton("PF_sample", "PF Sampling",
                                     class="btn btn-primary btn-custom")
                    )
             )
           )
  ),
  
  tabPanel("Audit Execution",
           br(),
           fluidRow(
             column(6,
                    div(class="card-core",
                        h4("Core Modules"),
                        actionButton("contract", "Contract Review",
                                     class="btn btn-success btn-custom"),
                        actionButton("voucher_review", "Voucher Review",
                                     class="btn btn-success btn-custom"),
                        actionButton("JV_review", "Journal Voucher Review",
                                     class="btn btn-success btn-custom")
                    )
             ),
             column(6,
                    div(class="card-other",
                        h4("Other Modules"),
                        actionButton("Pension", "Pension Audit",
                                     class="btn btn-primary btn-custom"),
                        actionButton("DCRG", "DCRG Audit",
                                     class="btn btn-primary btn-custom"),
                        actionButton("PF", "PF Audit",
                                     class="btn btn-primary btn-custom")
                    )
             )
           )
  )
)

# ========================== SERVER ==========================

server <- function(input, output, session) {
  
  PORTABLE_R_HOME <- "D:/Compliance Audit_Stores_19.12.21/R Dashboard/R"
  APPS_HOME       <- "D:/Compliance Audit_Stores_19.12.21/R Dashboard/Apps"
  
  rscript_candidates <- c(
    file.path(PORTABLE_R_HOME,"bin","Rscript.exe"),
    file.path(PORTABLE_R_HOME,"bin","x64","Rscript.exe")
  )
  
  rscript_path <- rscript_candidates[file.exists(rscript_candidates)][1]
  
  launch_subapp <- function(subfolder_name) {
    
    app_dir <- normalizePath(
      file.path(APPS_HOME, subfolder_name),
      winslash="/",
      mustWork=FALSE
    )
    
    if (!dir.exists(app_dir)) {
      showModal(modalDialog(
        title="App folder not found",
        paste("Missing folder:", app_dir),
        easyClose=TRUE
      ))
      return(NULL)
    }
    
    cmd <- sprintf(
      "shiny::runApp('%s', launch.browser=TRUE)",
      app_dir
    )
    
    system2(
      rscript_path,
      args=c("-e", shQuote(cmd)),
      wait=FALSE
    )
  }
  
  app_map <- list(
    JV="JV",
    plan="Plan",
    risk="Risk",
    voucher="Voucher",
    tender="Tender",
    contract_sample="ContractSample",
    pension_sample="PensionSample",
    DCRG_sample="DCRGSample",
    PF_sample="PFSample",
    contract="Contract",
    voucher_review="VoucherReview",
    JV_review="JVReview",
    Pension="Pension",
    DCRG="DCRG",
    PF="PF"
  )
  
  lapply(names(app_map), function(btn_id){
    observeEvent(input[[btn_id]],{
      launch_subapp(app_map[[btn_id]])
    }, ignoreInit=TRUE)
  })
}

shinyApp(ui, server)

library(shiny)
library(bslib)

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
    
    /* GOLD STRIP */
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
    
    /* ===== BACKGROUND ===== */
    body {
      background-color: #f4f6f9;
    }
    
    /* ===== CORE MODULES (Enterprise Green) ===== */
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
    
    /* ===== OTHER MODULES (Enterprise Blue) ===== */
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
    
    /* ===== BUTTON STYLE ===== */
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
  
  
  # ---------------- Audit Planning ----------------
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
  
  
  # ---------------- Audit Sampling ----------------
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
                        actionButton("contract", "Completed Contract Sampling",
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
  
  
  # ---------------- Audit Execution ----------------
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

server <- function(input, output, session) {
  # Server logic placeholder
}

shinyApp(ui, server)

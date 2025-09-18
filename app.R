library(shiny)
library(ggplot2)
library(shiny.semantic)

# ---------- UI SECTION ONLY ----------
ui <- semanticPage(
  tags$head(
    tags$style(HTML("
      /* Light Theme (Campus Energy) */
      .light-theme {
        background: linear-gradient(135deg, #ff9068 0%, #fd746c 50%, #ff4757 100%);
        transition: all 0.5s ease;
      }

      /* Dark Theme (Modern Dark Mode) */
      .dark-theme {
        background: linear-gradient(135deg, #1a1a1a 0%, #2d2d2d 50%, #1a1a1a 100%);
        transition: all 0.5s ease;
      }

      body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        min-height: 100vh;
        position: relative;
        overflow-x: hidden;
      }

      /* Background SVG Decorations */
      .bg-decoration {
        position: fixed;
        opacity: 0.1;
        z-index: 1;
        pointer-events: none;
      }

      .beaker-1 { top: 10%; left: 80%; width: 120px; height: 120px; }
      .test-tube-1 { top: 60%; right: 5%; width: 100px; height: 100px; }
      .flask-1 { bottom: 20%; left: 10%; width: 80px; height: 80px; }
      .molecule-1 { top: 30%; left: 5%; width: 90px; height: 90px; }
      .test-tube-1 { bottom: 50%; right: 15%; width: 70px; height: 70px; }
      .atom-1 { top: 70%; left: 75%; width: 85px; height: 85px; }

      /* Theme Toggle Button */
      .theme-toggle {
        position: fixed;
        top: 20px;
        right: 20px;
        z-index: 1000;
        background: rgba(255, 255, 255, 0.2) !important;
        backdrop-filter: blur(10px);
        border: 2px solid rgba(255, 255, 255, 0.3) !important;
        border-radius: 50px !important;
        color: white !important;
        font-weight: 600;
        padding: 10px 20px !important;
        transition: all 0.3s ease;
      }

      .theme-toggle:hover {
        background: rgba(255, 255, 255, 0.3) !important;
        transform: scale(1.05);
      }

      /* Light Theme Styles */
      .light-theme .ui.tabular.menu {
        margin-bottom: 0 !important;
        border-bottom: none !important;
        background: transparent !important;
        padding: 0 20px !important;
      }

      .light-theme .ui.tabular.menu .item {
        background: rgba(255, 255, 255, 0.8) !important;
        border-radius: 15px 15px 0 0 !important;
        margin-right: 8px !important;
        margin-bottom: 0 !important;
        color: #e55039 !important;
        font-weight: 600;
        border: 2px solid rgba(229, 80, 57, 0.2) !important;
        border-bottom: none !important;
        transition: all 0.3s ease;
        position: relative;
        z-index: 10;
      }

      .light-theme .ui.tabular.menu .item:hover {
        background: rgba(255, 255, 255, 0.95) !important;
        transform: translateY(-2px);
        box-shadow: 0 4px 15px rgba(229, 80, 57, 0.2);
      }

      .light-theme .ui.tabular.menu .item.active {
        background: linear-gradient(45deg, #ff6b35, #f7931e) !important;
        color: white !important;
        border-color: #ff6b35 !important;
        z-index: 15;
      }

      .light-theme .ui.tab.segment {
        background: rgba(255, 255, 255, 0.95) !important;
        backdrop-filter: blur(10px);
        border: 2px solid rgba(229, 80, 57, 0.2) !important;
        border-radius: 0 15px 15px 15px !important;
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1) !important;
        margin-top: 0 !important;
        border-top-left-radius: 0 !important;
      }

      .light-theme .ui.segment {
        background: rgba(255, 255, 255, 0.95) !important;
        backdrop-filter: blur(10px);
        border: 1px solid rgba(247, 147, 30, 0.3) !important;
        border-radius: 20px !important;
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1) !important;
      }

      .light-theme .ui.button.primary {
        background: linear-gradient(45deg, #ff6b35, #f7931e) !important;
        border: none !important;
        border-radius: 25px !important;
        color: white !important;
        font-weight: 600;
        transition: all 0.3s ease;
        box-shadow: 0 4px 15px rgba(255, 107, 53, 0.3);
      }

      .light-theme .ui.button.primary:hover {
        background: linear-gradient(45deg, #ff7f50, #ffa500) !important;
        transform: translateY(-3px);
        box-shadow: 0 6px 20px rgba(255, 107, 53, 0.5) !important;
      }

      .light-theme .ui.input > input,
      .light-theme .ui.form textarea {
        border: 2px solid #ffb347 !important;
        border-radius: 15px !important;
        padding: 6px 16px !important;
        font-size: 14px;
        transition: all 0.3s ease;
        height: 30px !important;
      }

      .light-theme .ui.input > input:focus,
      .light-theme .ui.form textarea:focus {
        border-color: #ff6b35 !important;
        box-shadow: 0 0 0 3px rgba(255, 107, 53, 0.2) !important;
        outline: none !important;
      }

      .light-theme .ui.header {
        color: #e55039 !important;
        font-weight: 700;
        text-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
      }

      .light-theme h1.ui.header {
        color: white !important;
        text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
        margin-bottom: 30px !important;
      }

      .light-theme .field > label {
        color: #e55039 !important;
        font-weight: 600;
        margin-bottom: 8px;
      }

      /* Dark Theme Styles */
      .dark-theme .ui.tabular.menu {
        margin-bottom: 0 !important;
        border-bottom: none !important;
        background: transparent !important;
        padding: 0 20px !important;
      }

      .dark-theme .ui.tabular.menu .item {
        background: rgba(255, 255, 255, 0.08) !important;
        border-radius: 15px 15px 0 0 !important;
        margin-right: 8px !important;
        margin-bottom: 0 !important;
        color: #e0e0e0 !important;
        font-weight: 600;
        border: 2px solid rgba(255, 255, 255, 0.1) !important;
        border-bottom: none !important;
        transition: all 0.3s ease;
        position: relative;
        z-index: 10;
      }

      .dark-theme .ui.tabular.menu .item:hover {
        background: rgba(255, 255, 255, 0.15) !important;
        transform: translateY(-2px);
        box-shadow: 0 4px 15px rgba(255, 255, 255, 0.1);
        color: #ffffff !important;
      }

      .dark-theme .ui.tabular.menu .item.active {
        background: linear-gradient(45deg, #4a4a4a, #6a6a6a) !important;
        color: #ffffff !important;
        border-color: #888888 !important;
        z-index: 15;
      }

      .dark-theme .ui.tab.segment {
        background: rgba(45, 45, 45, 0.95) !important;
        backdrop-filter: blur(15px);
        border: 2px solid rgba(100, 100, 100, 0.3) !important;
        border-radius: 0 15px 15px 15px !important;
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.5) !important;
        margin-top: 0 !important;
        border-top-left-radius: 0 !important;
      }

      .dark-theme .ui.segment {
        background: rgba(35, 35, 35, 0.95) !important;
        backdrop-filter: blur(15px);
        border: 1px solid rgba(80, 80, 80, 0.3) !important;
        border-radius: 20px !important;
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.4) !important;
      }

      .dark-theme .ui.button.primary {
        background: linear-gradient(45deg, #6c5ce7, #a29bfe) !important;
        border: none !important;
        border-radius: 25px !important;
        color: white !important;
        font-weight: 600;
        transition: all 0.3s ease;
        box-shadow: 0 4px 15px rgba(108, 92, 231, 0.4);
      }

      .dark-theme .ui.button.primary:hover {
        background: linear-gradient(45deg, #7b68ee, #b19cd9) !important;
        transform: translateY(-3px);
        box-shadow: 0 6px 20px rgba(108, 92, 231, 0.6) !important;
      }

      .dark-theme .ui.input > input,
      .dark-theme .ui.form textarea,
      .dark-theme input,
      .dark-theme textarea,
      .dark-theme .ui.dropdown {
        border: 2px solid #81ecec !important;
        border-radius: 15px !important;
        padding: 6px 16px !important;
        font-size: 14px;
        transition: all 0.3s ease;
        background: rgba(255, 255, 255, 0.1) !important;
        color: white !important;
        height: 30px !important;
      }

      .dark-theme .ui.dropdown .menu {
        background: rgba(35, 35, 35, 0.95) !important;
        border: 1px solid #81ecec !important;
        border-radius: 10px !important;
      }

      .dark-theme .ui.dropdown .menu .item {
        color: white !important;
        border-bottom: 1px solid rgba(255, 255, 255, 0.1) !important;
      }

      .dark-theme .ui.dropdown .menu .item:hover {
        background: rgba(108, 92, 231, 0.2) !important;
        color: #a29bfe !important;
      }

      .dark-theme .ui.dropdown.visible {
        border-color: #6c5ce7 !important;
        box-shadow: 0 0 0 3px rgba(108, 92, 231, 0.3) !important;
      }

      .dark-theme .ui.input > input:focus,
      .dark-theme .ui.form textarea:focus {
        border-color: #6c5ce7 !important;
        box-shadow: 0 0 0 3px rgba(108, 92, 231, 0.3) !important;
        outline: none !important;
      }

      .dark-theme .ui.header {
        color: #6c5ce7 !important;
        font-weight: 700;
        text-shadow: 0 2px 4px rgba(0, 0, 0, 0.5);
      }

      .dark-theme h1.ui.header {
        color: #f8f9fa !important;
        text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.7);
        margin-bottom: 30px !important;
      }

      .dark-theme .field > label {
        color: #4ecdc4 !important;
        font-weight: 600;
        margin-bottom: 8px;
      }

      /* Common styles for both themes */
      .ui.form textarea {
        min-height: 80px;
      }

      .ui.table {
        margin-top: 20px;
        border-radius: 15px !important;
        overflow: hidden;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
      }

      .light-theme .ui.table {
        background: rgba(255, 255, 255, 0.95) !important;
      }

      .dark-theme .ui.table {
        background: rgba(255, 255, 255, 0.1) !important;
      }

      .light-theme .ui.table thead th {
        background: linear-gradient(45deg, #ff6b35, #f7931e) !important;
        color: white !important;
        font-weight: 600;
      }

      .dark-theme .ui.table thead th {
        background: linear-gradient(45deg, #6c5ce7, #a29bfe) !important;
        color: white !important;
        font-weight: 600;
      }

      .dark-theme .ui.table tbody td {
        color: white !important;
      }

      .ui.container {
        padding: 20px;
        position: relative;
        z-index: 2;
      }

      /* Tooltip styles */
      .info-tooltip {
        display: inline-block;
        margin-left: 5px;
        cursor: help;
        color: #74b9ff;
        font-weight: bold;
      }

      .tooltip-content {
        visibility: hidden;
        width: 250px;
        background-color: rgba(0, 0, 0, 0.9);
        color: white;
        text-align: center;
        border-radius: 10px;
        padding: 10px;
        position: absolute;
        z-index: 1000;
        bottom: 125%;
        left: 50%;
        margin-left: -125px;
        opacity: 0;
        transition: opacity 0.3s;
        font-size: 12px;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.3);
      }

      .tooltip-content::after {
        content: '';
        position: absolute;
        top: 100%;
        left: 50%;
        margin-left: -5px;
        border-width: 5px;
        border-style: solid;
        border-color: rgba(0, 0, 0, 0.9) transparent transparent transparent;
      }

      .info-tooltip:hover .tooltip-content {
        visibility: visible;
        opacity: 1;
      }

      /* Student-friendly animations */
      @keyframes pulse {
        0% { transform: scale(1); }
        50% { transform: scale(1.05); }
        100% { transform: scale(1); }
      }

      @keyframes float {
        0%, 100% { transform: translateY(0px); }
        50% { transform: translateY(-10px); }
      }

      .ui.button.primary {
        animation: pulse 3s infinite;
      }

      .ui.button.primary:hover {
        animation: none;
      }

      .bg-decoration {
        animation: float 6s ease-in-out infinite;
      }

      .bg-decoration:nth-child(even) {
        animation-delay: 3s;
      }

      /* Responsive improvements */
      @media (max-width: 768px) {
        .bg-decoration {
          display: none;
        }
        
        .theme-toggle {
          position: relative;
          top: 0;
          right: 0;
          margin-bottom: 20px;
        }
      }
    "))
  ),
  tags$head(
    tags$link(rel = "stylesheet", href = "https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap"),
    tags$script(HTML("
      Shiny.addCustomMessageHandler('changeTheme', function(message) {
        document.getElementById('main-content').className = message.theme;
        document.getElementById('themeToggle').innerHTML = message.buttonText;
      });
    "))
  ),
  
  # Background decorations
  tags$div(class = "bg-decoration beaker-1",
           HTML('<svg viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">
      <path d="M30 20 L30 40 L20 70 L80 70 L70 40 L70 20 Z" fill="currentColor" stroke="currentColor" stroke-width="2"/>
      <rect x="25" y="15" width="50" height="10" fill="currentColor"/>
      <circle cx="35" cy="55" r="3" fill="white" opacity="0.6"/>
      <circle cx="50" cy="60" r="2" fill="white" opacity="0.6"/>
      <circle cx="65" cy="52" r="2.5" fill="white" opacity="0.6"/>
    </svg>')
  ),
  tags$div(class = "bg-decoration microscope-1",
           HTML('<svg viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">
      <rect x="20" y="80" width="60" height="10" fill="currentColor"/>
      <rect x="45" y="30" width="10" height="50" fill="currentColor"/>
      <circle cx="50" cy="25" r="15" fill="currentColor"/>
      <circle cx="50" cy="25" r="8" fill="white" opacity="0.8"/>
      <rect x="35" y="50" width="30" height="8" fill="currentColor"/>
      <circle cx="30" cy="54" r="4" fill="currentColor"/>
    </svg>')
  ),
  tags$div(class = "bg-decoration flask-1",
           HTML('<svg viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">
      <path d="M35 10 L35 35 L15 70 L85 70 L65 35 L65 10 Z" fill="currentColor"/>
      <rect x="30" y="5" width="40" height="10" fill="currentColor"/>
      <rect x="47" y="0" width="6" height="15" fill="currentColor"/>
      <path d="M25 50 Q50 45 75 50 Q60 55 50 60 Q40 55 25 50" fill="white" opacity="0.3"/>
    </svg>')
  ),
  tags$div(class = "bg-decoration molecule-1",
           HTML('<svg viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">
      <circle cx="30" cy="30" r="8" fill="currentColor"/>
      <circle cx="70" cy="30" r="8" fill="currentColor"/>
      <circle cx="50" cy="60" r="8" fill="currentColor"/>
      <circle cx="30" cy="80" r="8" fill="currentColor"/>
      <line x1="38" y1="30" x2="62" y2="30" stroke="currentColor" stroke-width="3"/>
      <line x1="35" y1="37" x2="45" y2="53" stroke="currentColor" stroke-width="3"/>
      <line x1="65" y1="37" x2="55" y2="53" stroke="currentColor" stroke-width="3"/>
      <line x1="45" y1="67" x2="35" y2="73" stroke="currentColor" stroke-width="3"/>
    </svg>')
  ),
  tags$div(class = "bg-decoration test-tube-1",
           HTML('<svg viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">
      <rect x="40" y="10" width="20" height="60" rx="10" fill="currentColor"/>
      <rect x="35" y="5" width="30" height="10" fill="currentColor"/>
      <rect x="42" y="50" width="16" height="18" fill="white" opacity="0.6"/>
      <circle cx="50" cy="45" r="2" fill="white" opacity="0.8"/>
    </svg>')
  ),
  tags$div(class = "bg-decoration atom-1",
           HTML('<svg viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">
      <circle cx="50" cy="50" r="6" fill="currentColor"/>
      <ellipse cx="50" cy="50" rx="30" ry="15" fill="none" stroke="currentColor" stroke-width="2"/>
      <ellipse cx="50" cy="50" rx="15" ry="30" fill="none" stroke="currentColor" stroke-width="2"/>
      <ellipse cx="50" cy="50" rx="35" ry="8" fill="none" stroke="currentColor" stroke-width="2" transform="rotate(60 50 50)"/>
    </svg>')
  ),
  
  div(id = "main-content", class = "light-theme",
      # Theme toggle button
      action_button("themeToggle", "🌙 Dark Mode", class = "theme-toggle"),
      
      div(class = "ui container",
          h1("Environmental Lab Data Analysis", class = "ui center aligned header"),
          tags$p("Analyze your environmental measurements with statistical precision!", 
                 class = "ui center aligned", 
                 style = "color: white; font-size: 16px; margin-bottom: 30px; text-shadow: 1px 1px 2px rgba(0,0,0,0.3);"),
          
          tabset(
            # ---- Tab 1: Data entry + Stats ----
            tabs = list(
              list(
                menu = "📊 Statistics",
                content = div(
                  class = "ui grid",
                  div(
                    class = "six wide column",
                    segment(
                      h3("🔢 Input Your Lab Data", class = "ui header"),
                      tags$div(style = "background: rgba(116, 185, 255, 0.1); padding: 15px; border-radius: 10px; margin-bottom: 20px;",
                               tags$p("📝 Enter your environmental measurements below. Separate values with commas or spaces.", 
                                      style = "margin: 0; color: #74b9ff; font-weight: 500;")
                      ),
                      div(class = "ui form",
                          # Dynamic group inputs will be rendered here
                          uiOutput("dynamicGroups"),
                          div(class = "field", style = "margin-top: 18px; padding-top: 12px; border-top: 1px solid rgba(255, 255, 255, 0.1);",
                              action_button("addGroup", "➕ Add Group", class = "ui secondary button", style = "margin-right: 10px;"),
                              action_button("calculate", "🧮 Calculate Statistics", class = "ui primary button")
                          )
                      )
                    )
                  ),
                  div(
                    class = "ten wide column",
                    segment(
                      h3("📈 Statistical Results", class = "ui header"),
                      tags$div(style = "background: rgba(116, 185, 255, 0.1); padding: 15px; border-radius: 10px; margin-bottom: 20px;",
                               tags$p("🎯 Your calculated statistics will appear here. These values help you understand your data's central tendency and variability!", 
                                      style = "margin: 0; color: #74b9ff; font-weight: 500;")
                      ),
                      div(
                        uiOutput("statsTableWithTooltips")
                      )
                    )
                  )
                )
              ),
              
              # ---- Tab 2: Comparison Bar Plot ----
              list(
                menu = "📊 Group Comparison",
                content = div(
                  class = "ui grid",
                  div(
                    class = "four wide column",
                    segment(
                      h3("🎨 Plot Customization", class = "ui header"),
                      tags$div(style = "background: rgba(116, 185, 255, 0.1); padding: 15px; border-radius: 10px; margin-bottom: 20px;",
                               tags$p("🖼️ Customize your comparison plot to make it perfect for your lab report!", 
                                      style = "margin: 0; color: #74b9ff; font-weight: 500;")
                      ),
                      div(class = "ui form",
                          div(class = "field",
                              tags$label("Main Title:"),
                              text_input("mainTitle", value = "Environmental Measurements Comparison")
                          ),
                          div(class = "field",
                              tags$label("X Axis Title:"),
                              text_input("xTitle", value = "Measurement Type")
                          ),
                          div(class = "field",
                              tags$label("Y Axis Title:"),
                              text_input("yTitle", value = "Mean Value")
                          )
                      )
                    )
                  ),
                  div(
                    class = "twelve wide column",
                    segment(
                      h3("📊 Comparison Bar Plot with Error Bars", class = "ui header"),
                      tags$div(style = "background: rgba(116, 185, 255, 0.1); padding: 15px; border-radius: 10px; margin-bottom: 20px;",
                               tags$p("📊 This plot shows the mean values for each group with error bars representing standard error. Error bars help you see the uncertainty in your measurements!", 
                                      style = "margin: 0; color: #74b9ff; font-weight: 500;")
                      ),
                      plotOutput("barPlot", height = "500px")
                    )
                  )
                )
              ),
              
              # ---- Tab 3: Individual Group Plot ----
              list(
                menu = "🔍 Individual Analysis",
                content = div(
                  class = "ui grid",
                  div(
                    class = "four wide column",
                    segment(
                      h3("🎯 Group Selection", class = "ui header"),
                      tags$div(style = "background: rgba(116, 185, 255, 0.1); padding: 15px; border-radius: 10px; margin-bottom: 20px;",
                               tags$p("🔍 Explore individual data points from any group to understand the distribution of your measurements!", 
                                      style = "margin: 0; color: #74b9ff; font-weight: 500;")
                      ),
                      div(class = "ui form",
                          div(class = "field",
                              tags$label("Select Group to Analyze:"),
                              uiOutput("groupSelector")
                          ),
                          div(class = "field",
                              tags$label("Plot Title:"),
                              text_input("individualTitle", value = "Individual Measurements")
                          ),
                          div(class = "field",
                              tags$label("X Axis Title:"),
                              text_input("individualXTitle", value = "Observation Number")
                          ),
                          div(class = "field",
                              tags$label("Y Axis Title:"),
                              text_input("individualYTitle", value = "Measured Value")
                          ),
                          div(class = "field",
                              tags$label("Visualization Type:"),
                              dropdown_input("plotType", 
                                             choices = list(
                                               "📊 Bar Chart" = "bar",
                                               "📈 Line Plot" = "line",
                                               "🎯 Scatter Plot" = "point"
                                             ),
                                             value = "bar"
                              )
                          )
                      )
                    )
                  ),
                  div(
                    class = "twelve wide column",
                    segment(
                      h3("📊 Individual Data Visualization", class = "ui header"),
                      tags$div(style = "background: rgba(116, 185, 255, 0.1); padding: 15px; border-radius: 10px; margin-bottom: 20px;",
                               tags$p("This visualization shows each individual measurement from your selected group. Look for patterns, outliers, or trends in your data!", 
                                      style = "margin: 0; color: #74b9ff; font-weight: 500;")
                      ),
                      plotOutput("individualPlot", height = "500px")
                    )
                  )
                )
              )
            )
          )
      )
  )
)

# ---------- SERVER SECTION ----------
server <- function(input, output, session) {
  
  # ---- Theme Management ----
  # Reactive value to track current theme
  current_theme <- reactiveVal("light")

  # Theme toggle functionality
  observeEvent(input$themeToggle, {
    new_theme <- if(input$themeToggle %% 2 == 1) "dark" else "light"
    current_theme(new_theme)

    theme_class <- paste0(new_theme, "-theme")
    button_text <- if(new_theme == "dark") "☀️" else "🌙"

    # Send theme change message to UI
    session$sendCustomMessage("changeTheme", list(
      theme = theme_class,
      buttonText = button_text
    ))
  })

  # ---- Dynamic Group Management ----
  # Reactive value to track number of groups
  num_groups <- reactiveVal(2)

  # Reactive value to store input values across re-renders
  stored_input_values <- reactiveVal(list())

  # Add group functionality with value preservation
  observeEvent(input$addGroup, {
    current_num <- num_groups()
    if (current_num < 10) {  # Limit to 10 groups to prevent UI overload
      # Capture current input values before re-rendering
      current_vals <- list()
      for(i in 1:current_num) {
        name_key <- paste0("name", i)
        group_key <- paste0("group", i)
        current_vals[[name_key]] <- input[[name_key]]
        current_vals[[group_key]] <- input[[group_key]]
      }
      stored_input_values(current_vals)

      # Increment group count (this will trigger UI re-render)
      num_groups(current_num + 1)
    } else {
      showNotification("⚠️ Maximum of 10 groups allowed!", type = "warning", duration = 3)
    }
  })

  # Render dynamic group inputs with value restoration
  output$dynamicGroups <- renderUI({
    n <- num_groups()
    stored_vals <- stored_input_values()

    group_inputs <- lapply(1:n, function(i) {
      # Get stored values for this group (if they exist)
      name_val <- stored_vals[[paste0("name", i)]]
      group_val <- stored_vals[[paste0("group", i)]]

      list(
        div(class = "field",
            tags$label(paste("Name for Group", i, ":")),
            text_input(
              paste0("name", i),
              value = if(!is.null(name_val)) name_val else "",
              placeholder = paste("eg: Water pH", i)
            )
        ),
        div(class = "field",
            tags$label(paste("Group", i, "measurements:")),
            textAreaInput(
              paste0("group", i),
              label = NULL,
              value = if(!is.null(group_val)) group_val else "",
              placeholder = "e.g., 7.2, 7.1, 7.3, 7.0, 7.4",
              width = "100%"
            )
        )
      )
    })
    do.call(tagList, unlist(group_inputs, recursive = FALSE))
  })
  
  # ---- Data Processing Functions ----
  
  # Helper function: parse numeric vector from text (commas OR spaces)
  parse_vec <- function(txt) {
    if (is.null(txt) || txt == "" || nchar(trimws(txt)) == 0) return(numeric(0))
    
    # Split by commas, spaces, or both
    vals <- unlist(strsplit(trimws(txt), "[,\\s]+"))
    vals <- vals[nzchar(vals)]  # Remove empty strings
    
    # Convert to numeric and handle warnings
    numeric_vals <- suppressWarnings(as.numeric(vals))
    
    # Return only valid numeric values
    numeric_vals[!is.na(numeric_vals)]
  }
  
  # ---- Main Data Collection ----

  # Collect and validate groups when Calculate button is clicked
  data <- eventReactive(input$calculate, {
    groups <- list()
    group_count <- 0
    n <- num_groups()

    # Process each of the current groups
    for (i in 1:n) {
      group_data <- parse_vec(input[[paste0("group", i)]])
      group_name <- trimws(input[[paste0("name", i)]])

      # Only include groups with valid data and names
      if (length(group_data) > 0 && group_name != "" && !is.null(group_name)) {
        groups[[group_name]] <- group_data
        group_count <- group_count + 1
      }
    }

    # Validation and user feedback
    if (group_count == 0) {
      showNotification(
        "🚨 Please provide data for at least 1 group to analyze! Enter group name and measurements.",
        type = "error",
        duration = 5
      )
      return(NULL)
    }

    # Success notification with helpful info
    total_measurements <- sum(sapply(groups, length))
    showNotification(
      paste0("✅ Success! Analyzed ", group_count, " group(s) with ", total_measurements, " total measurements."),
      type = "message",
      duration = 4
    )

    groups
  })
  
  # ---- Statistical Calculations ----
  
  # Compute comprehensive statistics for all groups
  stats <- reactive({
    req(data())
    groups <- data()
    
    # Calculate statistics for each group
    stats_df <- data.frame(
      Group = names(groups),
      Mean = round(sapply(groups, mean), 3),
      Std_Error = round(sapply(groups, function(x) {
        if(length(x) > 1) sd(x) / sqrt(length(x)) else 0
      }), 4),
      Std_Dev = round(sapply(groups, function(x) {
        if(length(x) > 1) sd(x) else 0
      }), 3),
      N = sapply(groups, length),
      Min = round(sapply(groups, min), 3),
      Max = round(sapply(groups, max), 3),
      check.names = FALSE
    )
    
    # Add student-friendly emoji column names
    colnames(stats_df) <- c("📊 Group", "📈 Mean", "📏 Std_Error", "📐 Std_Dev", "🔢 N", "⬇️ Min", "⬆️ Max")
    
    stats_df
  })
  
  # ---- UI Outputs ----

  # Render statistics table with tooltips on column headers
  output$statsTableWithTooltips <- renderUI({
    req(stats())
    df <- stats()

    # Create HTML table with tooltips
    table_html <- tags$table(
      class = "ui table striped celled",
      tags$thead(
        tags$tr(
          tags$th("📊 Group"),
          tags$th(title = "Average value of all measurements in the group", "📈 Mean"),
          tags$th(title = "Standard Error measures how much your sample mean might differ from the true population mean. Smaller values = more precise estimates!", "📏 Std_Error"),
          tags$th(title = "Standard Deviation measures the spread of your data points around the mean. Larger values = more variability!", "📐 Std_Dev"),
          tags$th(title = "N is your sample size - the number of measurements you took. Larger N generally gives more reliable results!", "🔢 N"),
          tags$th("⬇️ Min"),
          tags$th("⬆️ Max")
        )
      ),
      tags$tbody(
        lapply(1:nrow(df), function(i) {
          tags$tr(
            tags$td(as.character(df[i, 1])),
            tags$td(as.character(df[i, 2])),
            tags$td(as.character(df[i, 3])),
            tags$td(as.character(df[i, 4])),
            tags$td(as.character(df[i, 5])),
            tags$td(as.character(df[i, 6])),
            tags$td(as.character(df[i, 7]))
          )
        })
      )
    )

    table_html
  })
  
  # Generate dynamic group selector dropdown for individual analysis
  output$groupSelector <- renderUI({
    req(data())
    groups <- data()
    
    # Create choices with emoji prefixes for visual appeal
    choices <- as.list(names(groups))
    names(choices) <- paste("🔬", names(groups))
    
    dropdown_input("selectedGroup", 
                   choices = choices,
                   value = names(groups)[1]
    )
  })
  
  # ---- Plot Theme Management ----
  
  # Get current theme colors for consistent plotting
  plot_theme_colors <- reactive({
    theme <- current_theme()

    if (theme == "dark") {
      list(
        primary = c("#6c5ce7", "#a29bfe", "#81ecec", "#00b894", "#e17055"),
        text = "#a29bfe",
        background = "#1a1a1a",
        grid_color = "#ff6b35"
      )
    } else {
      list(
        primary = c("#ff6b35", "#f7931e", "#ffb347", "#ff7f50", "#ffa500"),
        text = "#e55039",
        background = "transparent",
        grid_color = "#6c5ce7"
      )
    }
  })
  
  # ---- Group Comparison Plot ----
  
  # Generate comparison bar plot with error bars
  output$barPlot <- renderPlot({
    req(stats())
    df <- stats()
    colors <- plot_theme_colors()
    
    # Clean group names for plotting (remove emojis)
    df$Group_Clean <- gsub("📊 ", "", df$`📊 Group`)
    
    # Create the main plot
    p <- ggplot(df, aes(x = reorder(Group_Clean, `📈 Mean`), y = `📈 Mean`, fill = Group_Clean)) +
      geom_bar(stat = "identity", alpha = 0.85, width = 0.7) +
      geom_errorbar(
        aes(ymin = `📈 Mean` - `📏 Std_Error`, ymax = `📈 Mean` + `📏 Std_Error`),
        width = 0.25,
        color = colors$primary[4],  # Use theme-appropriate color for visibility
        size = 1.2,
        alpha = 0.9
      ) +
      
      # Customization based on user inputs
      labs(
        title = input$mainTitle, 
        y = input$yTitle, 
        x = input$xTitle,
        caption = "Error bars represent Standard Error of the Mean"
      ) +
      
      # Educational theme with clear axis lines
      theme_classic() +
      theme(
        legend.position = "none",
        plot.title = element_text(hjust = 0.5, size = 20, color = colors$text, face = "bold", margin = margin(b = 20)),
        plot.caption = element_text(size = 10, color = colors$text, face = "italic"),
        axis.title = element_text(size = 14, color = colors$text, face = "bold"),
        axis.text = element_text(size = 12, color = colors$text),
        axis.text.x = element_text(angle = 45, hjust = 1, size = 11),
        axis.line = element_line(color = colors$text, size = 1.2),
        axis.ticks = element_line(color = colors$text, size = 1),
        axis.ticks.length = unit(0.3, "cm"),
        panel.grid.major.y = element_line(color = paste0(colors$grid_color, "30"), size = 0.3),
        panel.grid.minor = element_blank(),
        panel.grid.major.x = element_blank(),
        plot.background = element_rect(fill = colors$background, color = NA),
        panel.background = element_rect(fill = colors$background, color = NA),
        plot.margin = margin(20, 20, 20, 20)
      ) +

      # Color scheme and value labels
      scale_fill_manual(values = colors$primary) +
      geom_text(
        aes(label = paste0(round(`📈 Mean`, 2), "\n(n=", `🔢 N`, ")")),
        vjust = -1.2,
        color = colors$text,
        size = 3.5,
        fontface = "bold"
      ) +

      # Y-axis starts at zero for educational clarity
      scale_y_continuous(expand = expansion(mult = c(0, 0.15)), limits = c(0, NA))
    
    p
  }, bg = "transparent")
  
  # ---- Individual Group Analysis Plot ----

  # Generate individual group visualization
  output$individualPlot <- renderPlot({
    req(data(), input$selectedGroup, input$plotType)
    groups <- data()

    # Validate selected group exists
    if (!input$selectedGroup %in% names(groups)) {
      return(NULL)
    }

    selected_data <- groups[[input$selectedGroup]]
    colors <- plot_theme_colors()

    # Prepare data frame
    df_individual <- data.frame(
      observation = 1:length(selected_data),
      value = selected_data,
      group = input$selectedGroup
    )

    # Calculate statistics for annotation
    mean_val <- round(mean(selected_data), 3)
    std_err <- round(sd(selected_data) / sqrt(length(selected_data)), 4)
    std_dev <- round(sd(selected_data), 3)
    n_obs <- length(selected_data)

    # Create base plot
    p <- ggplot(df_individual, aes(x = observation, y = value))

    # Add geometry based on plot type selection
    if (input$plotType == "bar") {
      p <- p +
        geom_bar(stat = "identity", fill = colors$primary[1], alpha = 0.8, width = 0.7) +
        geom_text(aes(label = round(value, 2)), vjust = -0.3, color = colors$text, size = 3.2, fontface = "bold")

    } else if (input$plotType == "line") {
      p <- p +
        geom_line(color = colors$primary[1], size = 2, alpha = 0.9) +
        geom_point(color = colors$primary[2], size = 4, alpha = 0.9) +
        geom_text(aes(label = round(value, 2)), vjust = -0.8, color = colors$text, size = 3, fontface = "bold") +
        # Add mean line for reference
        geom_hline(yintercept = mean_val, linetype = "dashed", color = colors$primary[3], alpha = 0.7, size = 1)

    } else if (input$plotType == "point") {
      p <- p +
        geom_point(color = colors$primary[1], size = 5, alpha = 0.8) +
        geom_text(aes(label = round(value, 2)), vjust = -0.8, color = colors$text, size = 3, fontface = "bold") +
        # Add mean line for reference
        geom_hline(yintercept = mean_val, linetype = "dashed", color = colors$primary[3], alpha = 0.7, size = 1)
    }

    # Apply educational theme with clear axis lines
    p <- p +
      theme_classic() +
      labs(
        title = paste(input$individualTitle, ":", input$selectedGroup),
        y = input$individualYTitle,
        x = input$individualXTitle
      ) +
      theme(
        plot.title = element_text(hjust = 0.5, size = 16, color = colors$text, face = "bold"),
        plot.subtitle = element_text(hjust = 0.5, size = 12, color = colors$text, face = "italic"),
        axis.title = element_text(size = 14, color = colors$text, face = "bold"),
        axis.text = element_text(size = 11, color = colors$text),
        axis.line = element_line(color = colors$text, size = 1.2),
        axis.ticks = element_line(color = colors$text, size = 1),
        axis.ticks.length = unit(0.3, "cm"),
        panel.grid.major.y = element_line(color = paste0(colors$grid_color, "30"), size = 0.3),
        panel.grid.minor = element_blank(),
        panel.grid.major.x = element_blank(),
        plot.background = element_rect(fill = colors$background, color = NA),
        panel.background = element_rect(fill = colors$background, color = NA),
        plot.margin = margin(20, 20, 20, 20)
      ) +
      scale_x_continuous(breaks = pretty(df_individual$observation)) +
      # Y-axis starts at zero for educational clarity (same as comparison plot)
      scale_y_continuous(
        limits = c(0, NA),
        expand = expansion(mult = c(0, 0.15)),
        breaks = scales::breaks_pretty(n = 5))

    p
  }, bg = "transparent")
  
  # ---- Additional Helper Functions ----

  # Data validation and quality checks - dynamic for current groups
  observe({
    n <- num_groups()
    # Monitor for common data entry issues and provide helpful hints
    lapply(1:n, function(i) {
      observeEvent(input[[paste0("group", i)]], {
        raw_data <- input[[paste0("group", i)]]
        if (!is.null(raw_data) && nchar(trimws(raw_data)) > 0) {
          parsed_data <- parse_vec(raw_data)

          # Check for potential parsing issues
          raw_vals <- unlist(strsplit(trimws(raw_data), "[,\\s]+"))
          raw_vals <- raw_vals[nzchar(raw_vals)]

          if (length(parsed_data) < length(raw_vals)) {
            showNotification(
              paste0("⚠️ Group ", i, ": Some values couldn't be parsed as numbers. Check for typos!"),
              type = "warning",
              duration = 3
            )
          }
        }
      }, ignoreInit = TRUE)
    })
  })
}

shinyApp(ui = ui, server = server)

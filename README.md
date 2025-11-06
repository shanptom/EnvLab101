# EnvLab101

**EnvLab101** is an interactive web-based application designed for environmental lab data analysis. Built with R Shiny, this educational tool helps students and researchers perform statistical calculations, visualize data, and create publication-ready plots with ease.

## Features

### Statistical Analysis
- **Comprehensive Statistics**: Calculate mean, standard error, standard deviation, minimum, maximum, and sample size for multiple data groups
- **Multi-Group Support**: Analyze up to 10 different measurement groups simultaneously
- **Real-time Calculations**: Interactive calculations with instant feedback and validation

### Data Visualization
- **Group Comparison Plots**: Bar charts with error bars for comparing multiple groups
- **Individual Analysis**: Detailed visualization of individual measurements with three plot types:
  - Bar charts
  - Line plots
  - Scatter plots
- **Customizable Plots**: Fully customizable titles, axis labels, and visualization styles

### User Interface
- **Dual Theme Support**: Switch between light (Campus Energy) and dark (Modern Dark Mode) themes
- **Responsive Design**: Works seamlessly on desktop and mobile devices
- **Intuitive Layout**: Clean, educational interface with helpful tooltips and guidance
- **Modern Aesthetics**: Gradient backgrounds with animated SVG decorations (beakers, flasks, molecules)

### Educational Features
- **Helpful Tooltips**: Hover over column headers for explanations of statistical concepts
- **Input Validation**: Real-time feedback on data entry with error notifications
- **Informative Messages**: Contextual guidance throughout the application
- **Publication-Ready Output**: Generate professional plots suitable for lab reports and presentations

## Technologies Used

- **R** (v3.5+)
- **Shiny** - Web application framework
- **shiny.semantic** - Semantic UI integration for modern design
- **ggplot2** - Advanced data visualization
- **HTML/CSS/JavaScript** - Custom UI enhancements

## Installation

### Prerequisites

1. **R** (version 3.5 or higher)
2. **R Packages**:
   ```r
   install.packages(c("shiny", "ggplot2", "shiny.semantic"))
   ```

### Running the Application

1. **Clone the repository**:
   ```bash
   git clone https://github.com/shanptom/EnvLab101.git
   cd EnvLab101
   ```

2. **Launch the app**:
   ```r
   # Open R or RStudio and run:
   shiny::runApp("app.R")
   ```

3. **Access the application**:
   - The app will automatically open in your default web browser
   - Typically accessible at `http://127.0.0.1:PORT` (port number will be displayed in console)

## Usage Guide

### 1. Entering Data

#### Statistics Tab
1. Navigate to the **∑ Statistics** tab
2. Enter a descriptive name for each group (e.g., "Water pH", "Soil Temperature")
3. Input your measurements:
   - Separate values with commas: `7.2, 7.1, 7.3, 7.0, 7.4`
   - Or use spaces: `7.2 7.1 7.3 7.0 7.4`
4. Click **Add Group** to add more measurement groups (up to 10)
5. Click **Calculate Statistics** to generate results

**Tip**: The app validates your input and provides helpful notifications for any issues.

### 2. Viewing Statistics

After calculation, you'll see a comprehensive table with:
- **Mean**: Average of all measurements
- **Std_Error**: Standard error of the mean (measures precision)
- **Std_Dev**: Standard deviation (measures variability)
- **N**: Sample size (number of measurements)
- **Min/Max**: Range of your data

Hover over column headers for detailed explanations of each statistic.

### 3. Creating Comparison Plots

#### Group Comparison Tab
1. Navigate to the **📊 Group Comparison** tab
2. Customize your plot:
   - Main Title
   - X-axis Title
   - Y-axis Title
3. View your bar chart with error bars showing standard error

**Best Practice**: Error bars help visualize the uncertainty in your measurements.

### 4. Analyzing Individual Groups

#### Individual Analysis Tab
1. Navigate to the **📉 Individual Analysis** tab
2. Select a group from the dropdown menu
3. Choose your visualization type:
   - **Bar Chart**: Best for comparing discrete measurements
   - **Line Plot**: Shows trends across observations
   - **Scatter Plot**: Emphasizes individual data points
4. Customize plot titles and axis labels
5. View individual measurements with statistical annotations

### 5. Theme Switching

Click the theme toggle button (🌙/☀️) in the top-right corner to switch between:
- **Light Theme**: Warm gradient (perfect for presentations)
- **Dark Theme**: Modern dark mode (easier on the eyes)

## Project Structure

```
EnvLab101/
├── app.R                 # Main Shiny application file
├── www/                  # Static assets directory
│   └── favicon.png      # Application favicon
├── rsconnect/           # Deployment configuration
├── manifest.json        # App manifest
└── README.md            # This file
```

## Key Features Explained

### Dynamic Group Management
- Start with 2 groups by default
- Add up to 10 groups dynamically
- Input values are preserved when adding new groups
- Remove empty or invalid groups automatically

### Statistical Methods
- **Mean**: Simple arithmetic average
- **Standard Error**: `SD / sqrt(N)` - measures precision of the mean estimate
- **Standard Deviation**: Measures spread of data around the mean
- **Error Bars**: Visual representation of standard error on plots

### Responsive Design
- Adapts to different screen sizes
- Mobile-friendly interface
- Touch-optimized controls
- Accessible on tablets and smartphones

## Use Cases

EnvLab101 is perfect for:

- **Environmental Science Students**: Analyze field data from experiments
- **Laboratory Courses**: Quick statistical analysis during lab sessions
- **Research Projects**: Preliminary data exploration and visualization
- **Teaching**: Demonstrate statistical concepts interactively
- **Field Work**: Mobile-friendly interface for on-site analysis

## Example Workflow

1. **Field Collection**: Measure water pH at 5 different locations
2. **Data Entry**: Enter measurements for each location as separate groups
3. **Statistical Analysis**: Calculate mean pH and variability for each site
4. **Visualization**: Create comparison plot showing differences between sites
5. **Individual Review**: Examine individual measurements for outliers or patterns
6. **Export**: Take screenshots or save plots for your lab report

## Deployment

The application can be deployed to:

- **Shinyapps.io**: Cloud hosting for Shiny apps
- **RStudio Connect**: Enterprise deployment platform
- **Shiny Server**: Self-hosted open-source server
- **Local Network**: Run on local machine and share via IP address

Deployment configuration is included in the `rsconnect/` directory.

## Browser Compatibility

EnvLab101 works best on:
- Chrome/Edge (Chromium) - v90+
- Firefox - v88+
- Safari - v14+
- Mobile browsers (iOS Safari, Chrome Mobile)

## Contributing

Contributions are welcome! If you'd like to improve EnvLab101:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/YourFeature`)
3. Commit your changes (`git commit -m 'Add YourFeature'`)
4. Push to the branch (`git push origin feature/YourFeature`)
5. Open a Pull Request

### Areas for Contribution
- Additional statistical tests (t-tests, ANOVA, etc.)
- Export functionality (CSV, PDF reports)
- Data import from files
- More visualization types
- Internationalization (i18n)
- Accessibility improvements

## License

This project is available for educational and research purposes. Please contact the developer for commercial use inquiries.

## Support & Contact

**Developer**: [Visit Developer Website](https://shanptom.github.io)

For questions, bug reports, or feature requests:
- Open an issue on GitHub
- Contact the developer through the website

## Acknowledgments

- Built with [Shiny](https://shiny.rstudio.com/) by RStudio
- UI components from [Semantic UI](https://semantic-ui.com/)
- Visualizations powered by [ggplot2](https://ggplot2.tidyverse.org/)

## Version History

- **v2.0**: Major UI improvements with dual theme support
- **v1.x**: Initial release with core statistical features

---

**Made with ❤️ for environmental science education**

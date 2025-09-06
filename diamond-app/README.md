# Diamond Price Estimator

A modern React web application that provides accurate diamond price estimates based on statistical analysis of diamond characteristics.

### 🌐 [Live App Demo](https://pns-diamondcheck.vercel.app/)

## 🚀 Features

- **Price Estimation**: Get accurate price estimates based on diamond characteristics (carat, cut, clarity, color)
- **Educational Content**: Learn about the 4Cs of diamonds and how each factor impacts price
- **Interactive Interface**: User-friendly design with text inputs and dropdowns for easy data entry
- **Visualization**: See how different factors impact diamond prices
- **Responsive Design**: Works on desktop, tablet, and mobile devices

## 📋 Project Structure

- `src/components/`: React components used throughout the application
- `src/pages/`: Main page components for different routes
- `src/data/`: Data models and prediction functions
- `src/theme.js`: Material UI theme configuration

## 🔧 Technologies Used

- **React**: Frontend library for building user interfaces
- **Material UI**: React component library implementing Google's Material Design
- **React Router**: For handling navigation and routing
- **Chart.js**: For data visualization
- **JavaScript**: Programming language

## 📊 Statistical Model

The price estimation is based on multiple regression analysis of a comprehensive diamond dataset. The model considers:

- Carat weight (most significant factor)
- Cut quality
- Color grade
- Clarity grade
- Depth percentage
- Table percentage
- Physical dimensions

The statistical models achieve an R-squared value exceeding 0.95, indicating that they explain more than 95% of the variation in diamond prices.

## 🚀 Getting Started

### Prerequisites

- Node.js (v14.0.0 or later)
- npm (v6.0.0 or later)

### Installation

1. Clone the repository
   ```
   git clone https://github.com/Arjunmehta312/Stats-Project-Sem4.git
   cd Stats-Project-Sem4/diamond-app
   ```

2. Install dependencies
   ```
   npm install
   ```

3. Start the development server
   ```
   npm start
   ```

4. Open [http://localhost:3000](http://localhost:3000) to view it in the browser

### Building for Production

```
npm run build
```

This builds the app for production to the `build` folder.

## 🌐 Deployment

The application is currently deployed on Vercel at [https://pns-diamondcheck.vercel.app/](https://pns-diamondcheck.vercel.app/)

### Deploying to Vercel

1. Install Vercel CLI:
   ```
   npm install -g vercel
   ```

2. Deploy:
   ```
   vercel
   ```

### GitHub Pages Deployment

1. Update the `homepage` field in `package.json`:
   ```json
   "homepage": "https://arjunmehta312.github.io/Stats-Project-Sem4",
   ```

2. Install gh-pages package:
   ```
   npm install --save-dev gh-pages
   ```

3. Add deployment scripts to `package.json`:
   ```json
   "predeploy": "npm run build",
   "deploy": "gh-pages -d build"
   ```

4. Deploy:
   ```
   npm run deploy
   ```

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgements

- Diamond dataset analysis was conducted as part of a statistical research project
- The regression model coefficients are derived from analysis of approximately 50,000 diamond records
- This web application is part of the larger [Diamond Dataset Analysis project](https://github.com/Arjunmehta312/Stats-Project-Sem4)

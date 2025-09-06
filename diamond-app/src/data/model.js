// Diamond Price Model
// Based on regression analysis of the diamond dataset

// Regression coefficients from the advanced model
export const modelCoefficients = {
  // Base intercept
  intercept: -8444.03,
  
  // Continuous variables
  carat: 7756.43,
  depth: 115.82,
  table: -92.97,
  x: 817.13,
  y: 60.63,
  z: -341.99,
  
  // Categorical variables - cut
  cut: {
    'Fair': 0, // baseline
    'Good': 307.97,
    'Very Good': 678.23,
    'Premium': 726.16,
    'Ideal': 1164.62
  },
  
  // Categorical variables - color
  color: {
    'J': 0, // baseline
    'I': 486.89,
    'H': 676.55,
    'G': 1167.05,
    'F': 1401.23,
    'E': 1541.78,
    'D': 1835.42
  },
  
  // Categorical variables - clarity
  clarity: {
    'I1': 0, // baseline
    'SI2': 1883.51,
    'SI1': 2724.96,
    'VS2': 3539.00,
    'VS1': 3936.20,
    'VVS2': 4275.00,
    'VVS1': 4517.45,
    'IF': 4918.87
  }
};

// Function to predict diamond price
export const predictPrice = (diamond) => {
  if (!diamond.carat || diamond.carat <= 0) {
    return { prediction: 0, confidence: 0 };
  }

  let price = modelCoefficients.intercept;

  // Add continuous variables contribution
  price += diamond.carat * modelCoefficients.carat;
  
  if (diamond.depth) {
    price += diamond.depth * modelCoefficients.depth;
  }
  
  if (diamond.table) {
    price += diamond.table * modelCoefficients.table;
  }
  
  // Add categorical variables contribution
  if (diamond.cut && modelCoefficients.cut[diamond.cut]) {
    price += modelCoefficients.cut[diamond.cut];
  }
  
  if (diamond.color && modelCoefficients.color[diamond.color]) {
    price += modelCoefficients.color[diamond.color];
  }
  
  if (diamond.clarity && modelCoefficients.clarity[diamond.clarity]) {
    price += modelCoefficients.clarity[diamond.clarity];
  }
  
  // Calculate confidence interval (simplified)
  // In a real app, this would be based on the model's standard error
  const confidence = 0.15 * price; // 15% confidence interval
  
  return {
    prediction: Math.max(0, Math.round(price)),
    lowerBound: Math.max(0, Math.round(price - confidence)),
    upperBound: Math.max(0, Math.round(price + confidence))
  };
};

// Diamond characteristics options for the UI
export const diamondOptions = {
  cut: ['Fair', 'Good', 'Very Good', 'Premium', 'Ideal'],
  color: ['D', 'E', 'F', 'G', 'H', 'I', 'J'],
  clarity: ['IF', 'VVS1', 'VVS2', 'VS1', 'VS2', 'SI1', 'SI2', 'I1'],
};

// Feature descriptions for educational content
export const featureDescriptions = {
  carat: "Carat weight is the measurement of how much a diamond weighs. A metric 'carat' is defined as 200 milligrams.",
  cut: "Cut quality is how well a diamond's facets interact with light. Excellent cut diamonds reflect more light and appear more brilliant.",
  color: "Diamond color actually refers to the lack of color. The scale ranges from D (colorless) to Z (light yellow or brown).",
  clarity: "Clarity measures the absence of inclusions and blemishes. Flawless diamonds (very rare) have no inclusions even under magnification."
};

// Feature impact on price (relative importance)
export const featureImportance = {
  carat: 100,
  cut: 35,
  color: 45,
  clarity: 60
}; 
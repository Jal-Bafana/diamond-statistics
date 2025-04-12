import React from 'react';
import { Container, Box, Typography, Card, CardContent, Divider, Grid } from '@mui/material';
import AutoGraphIcon from '@mui/icons-material/AutoGraph';
import SchoolIcon from '@mui/icons-material/School';
import DataObjectIcon from '@mui/icons-material/DataObject';

const About = () => {
  return (
    <Box sx={{ pt: 4, pb: 8 }}>
      <Container maxWidth="lg">
        <Box sx={{ mb: 5, textAlign: 'center' }}>
          <Typography variant="h3" component="h1" gutterBottom>
            About This Project
          </Typography>
          <Typography variant="h6" color="text.secondary" sx={{ maxWidth: 800, mx: 'auto' }}>
            The Diamond Price Estimator is built on comprehensive statistical analysis of diamond characteristics and pricing
          </Typography>
        </Box>
        
        <Grid container spacing={4}>
          <Grid item xs={12} md={4}>
            <Card elevation={0} sx={{ height: '100%', border: '1px solid', borderColor: 'divider' }}>
              <CardContent sx={{ textAlign: 'center', display: 'flex', flexDirection: 'column', alignItems: 'center' }}>
                <AutoGraphIcon sx={{ fontSize: 60, color: 'primary.main', mb: 2 }} />
                <Typography variant="h5" component="h2" gutterBottom>
                  Statistical Analysis
                </Typography>
                <Typography variant="body1" align="left">
                  This tool is powered by regression models developed through rigorous statistical analysis 
                  of a comprehensive diamond dataset. The models identify the relationships between diamond 
                  characteristics and market prices, allowing for accurate price predictions for diamonds 
                  of varying qualities.
                </Typography>
              </CardContent>
            </Card>
          </Grid>
          
          <Grid item xs={12} md={4}>
            <Card elevation={0} sx={{ height: '100%', border: '1px solid', borderColor: 'divider' }}>
              <CardContent sx={{ textAlign: 'center', display: 'flex', flexDirection: 'column', alignItems: 'center' }}>
                <SchoolIcon sx={{ fontSize: 60, color: 'primary.main', mb: 2 }} />
                <Typography variant="h5" component="h2" gutterBottom>
                  Academic Foundation
                </Typography>
                <Typography variant="body1" align="left">
                  The project originated as an academic statistical analysis of diamond pricing factors, 
                  applying concepts from probability theory, regression analysis, and data visualization. 
                  The techniques used include multiple linear regression, variable importance analysis, 
                  and confidence interval estimation.
                </Typography>
              </CardContent>
            </Card>
          </Grid>
          
          <Grid item xs={12} md={4}>
            <Card elevation={0} sx={{ height: '100%', border: '1px solid', borderColor: 'divider' }}>
              <CardContent sx={{ textAlign: 'center', display: 'flex', flexDirection: 'column', alignItems: 'center' }}>
                <DataObjectIcon sx={{ fontSize: 60, color: 'primary.main', mb: 2 }} />
                <Typography variant="h5" component="h2" gutterBottom>
                  Technology Stack
                </Typography>
                <Typography variant="body1" align="left">
                  The web application is built using modern web technologies including React, Material UI, 
                  and Chart.js. The statistical analysis was performed using R programming language with packages 
                  like tidyverse, ggplot2, and various modeling libraries. This creates a seamless 
                  user experience while leveraging powerful statistical methods.
                </Typography>
              </CardContent>
            </Card>
          </Grid>
        </Grid>
        
        <Box sx={{ mt: 6 }}>
          <Typography variant="h4" component="h2" gutterBottom>
            The Diamond Dataset
          </Typography>
          <Divider sx={{ mb: 3 }} />
          <Typography variant="body1" paragraph>
            The statistical models powering this estimator were trained on a comprehensive dataset containing information on 
            approximately 50,000 diamonds with various combinations of characteristics. The dataset includes detailed information on:
          </Typography>
          <Grid container spacing={2} sx={{ mb: 3 }}>
            <Grid item xs={12} sm={6} md={3}>
              <Typography variant="subtitle1">• Carat weights</Typography>
              <Typography variant="subtitle1">• Cut qualities</Typography>
            </Grid>
            <Grid item xs={12} sm={6} md={3}>
              <Typography variant="subtitle1">• Color grades</Typography>
              <Typography variant="subtitle1">• Clarity grades</Typography>
            </Grid>
            <Grid item xs={12} sm={6} md={3}>
              <Typography variant="subtitle1">• Depth percentages</Typography>
              <Typography variant="subtitle1">• Table percentages</Typography>
            </Grid>
            <Grid item xs={12} sm={6} md={3}>
              <Typography variant="subtitle1">• Physical dimensions</Typography>
              <Typography variant="subtitle1">• Market prices</Typography>
            </Grid>
          </Grid>
          <Typography variant="body1" paragraph>
            Through extensive analysis of this dataset, we identified the key factors that influence diamond prices
            and quantified their impact. Our multiple regression models achieve high accuracy with an R-squared value 
            exceeding 0.95, indicating that our model explains more than 95% of the variation in diamond prices.
          </Typography>
        </Box>
        
        <Box sx={{ mt: 6 }}>
          <Typography variant="h4" component="h2" gutterBottom>
            Methodology
          </Typography>
          <Divider sx={{ mb: 3 }} />
          <Typography variant="body1" paragraph>
            Our price estimation model was developed using the following process:
          </Typography>
          <Box component="ol" sx={{ pl: 4 }}>
            <Typography component="li" variant="body1" sx={{ mb: 2 }}>
              <strong>Data Preparation:</strong> The dataset was cleaned, validated, and prepared for analysis. 
              Exploratory data analysis was performed to understand the distributions and relationships between variables.
            </Typography>
            <Typography component="li" variant="body1" sx={{ mb: 2 }}>
              <strong>Feature Engineering:</strong> We created relevant features and transformations to improve model performance. 
              This included handling categorical variables and exploring interactions between diamond characteristics.
            </Typography>
            <Typography component="li" variant="body1" sx={{ mb: 2 }}>
              <strong>Model Development:</strong> Multiple regression models were developed and evaluated. 
              The final model was selected based on predictive accuracy, interpretability, and robustness.
            </Typography>
            <Typography component="li" variant="body1" sx={{ mb: 2 }}>
              <strong>Validation:</strong> The model was validated using cross-validation techniques to ensure 
              it performs well on new, unseen data and isn't overfit to the training dataset.
            </Typography>
            <Typography component="li" variant="body1" sx={{ mb: 2 }}>
              <strong>Uncertainty Quantification:</strong> Confidence intervals were developed to provide 
              a range of estimated prices rather than a single point estimate, acknowledging the inherent 
              uncertainty in price prediction.
            </Typography>
          </Box>
        </Box>
        
        <Box sx={{ mt: 6, textAlign: 'center' }}>
          <Typography variant="body2" color="text.secondary">
            © {new Date().getFullYear()} Diamond Price Estimator
          </Typography>
          <Typography variant="body2" color="text.secondary" sx={{ mt: 1 }}>
            This tool is provided for educational and informational purposes only.
          </Typography>
        </Box>
      </Container>
    </Box>
  );
};

export default About; 
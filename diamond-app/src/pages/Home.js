import React from 'react';
import { Container, Box, Typography, Paper, Grid } from '@mui/material';
import EstimatorForm from '../components/EstimatorForm';
import FactorImpact from '../components/FactorImpact';

const Home = () => {
  return (
    <Box sx={{ pt: 4, pb: 8 }}>
      <Container maxWidth="lg">
        <Box sx={{ mb: 5, textAlign: 'center' }}>
          <Typography variant="h3" component="h1" gutterBottom>
            Diamond Price Estimator
          </Typography>
          <Typography variant="h6" color="text.secondary" sx={{ maxWidth: 800, mx: 'auto' }}>
            Get an accurate estimate of diamond prices based on advanced statistical analysis
          </Typography>
        </Box>
        
        <Paper 
          elevation={0} 
          sx={{ 
            p: { xs: 2, md: 4 }, 
            mb: 5, 
            borderRadius: 2, 
            backgroundColor: 'background.paper',
            border: '1px solid',
            borderColor: 'divider'
          }}
        >
          <EstimatorForm />
        </Paper>
        
        <Grid container spacing={4}>
          <Grid item xs={12}>
            <FactorImpact />
          </Grid>
        </Grid>
      </Container>
    </Box>
  );
};

export default Home; 
import React from 'react';
import { Box, Card, CardContent, Typography, Grid, LinearProgress, Tooltip } from '@mui/material';
import InfoOutlinedIcon from '@mui/icons-material/InfoOutlined';
import { featureImportance, featureDescriptions } from '../data/model';

const FactorImpact = () => {
  // Convert feature importance to an array and sort by importance
  const factors = Object.entries(featureImportance)
    .map(([name, importance]) => ({
      name,
      importance,
      description: featureDescriptions[name]
    }))
    .sort((a, b) => b.importance - a.importance);

  // Function to get display name with proper capitalization
  const getDisplayName = (name) => {
    return name.charAt(0).toUpperCase() + name.slice(1);
  };

  // Color mapping for different factors
  const getFactorColor = (factor) => {
    const colors = {
      carat: '#3f51b5', // primary
      cut: '#4caf50',   // green
      color: '#ff9800', // orange
      clarity: '#e91e63' // pink
    };
    return colors[factor] || '#757575';
  };

  return (
    <Card elevation={0}>
      <CardContent>
        <Typography variant="h5" component="h2" gutterBottom>
          Factor Impact on Price
        </Typography>
        <Typography variant="body2" color="text.secondary" sx={{ mb: 3 }}>
          Understand how different characteristics affect a diamond's price.
        </Typography>
        
        <Grid container spacing={3}>
          {factors.map((factor) => (
            <Grid item xs={12} key={factor.name}>
              <Box sx={{ mb: 1.5 }}>
                <Box sx={{ display: 'flex', alignItems: 'center', mb: 0.5 }}>
                  <Typography variant="body1" sx={{ fontWeight: 500 }}>
                    {getDisplayName(factor.name)}
                  </Typography>
                  <Tooltip title={factor.description} placement="right">
                    <InfoOutlinedIcon 
                      fontSize="small" 
                      color="action" 
                      sx={{ ml: 1, fontSize: 16 }} 
                    />
                  </Tooltip>
                </Box>
                <LinearProgress 
                  variant="determinate" 
                  value={factor.importance} 
                  sx={{ 
                    height: 10, 
                    borderRadius: 5,
                    backgroundColor: 'rgba(0, 0, 0, 0.05)',
                    '& .MuiLinearProgress-bar': {
                      backgroundColor: getFactorColor(factor.name),
                      borderRadius: 5,
                    }
                  }}
                />
                <Box sx={{ display: 'flex', justifyContent: 'space-between', mt: 0.5 }}>
                  <Typography variant="body2" color="text.secondary">
                    Relative Impact
                  </Typography>
                  <Typography variant="body2" color="text.secondary">
                    {factor.importance}%
                  </Typography>
                </Box>
              </Box>
            </Grid>
          ))}
        </Grid>
        
        <Box sx={{ mt: 2 }}>
          <Typography variant="body2" color="text.secondary">
            * Based on statistical analysis of the relationship between diamond characteristics and price.
          </Typography>
        </Box>
      </CardContent>
    </Card>
  );
};

export default FactorImpact; 
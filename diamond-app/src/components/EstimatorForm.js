import React, { useState, useEffect, useCallback } from 'react';
import {
  Box,
  Card,
  CardContent,
  Typography,
  TextField,
  MenuItem,
  Button,
  Grid,
  InputAdornment,
  Tooltip,
  Paper,
  Divider,
} from '@mui/material';
import InfoIcon from '@mui/icons-material/Info';
import { diamondOptions, predictPrice, featureDescriptions } from '../data/model';

const EstimatorForm = () => {
  const [diamond, setDiamond] = useState({
    carat: 1,
    cut: 'Ideal',
    color: 'D',
    clarity: 'IF',
    depth: 61.5,
    table: 56,
  });
  
  const [priceEstimate, setPriceEstimate] = useState(null);
  const [errors, setErrors] = useState({});

  // Using useCallback to memoize the calculateEstimate function
  const calculateEstimate = useCallback(() => {
    // Check if form is valid
    if (Object.keys(errors).length === 0) {
      const result = predictPrice(diamond);
      setPriceEstimate(result);
    }
  }, [diamond, errors]);

  useEffect(() => {
    // Calculate initial price estimate
    calculateEstimate();
  }, [calculateEstimate]);

  const handleChange = (event) => {
    const { name, value } = event.target;
    setDiamond(prev => ({
      ...prev,
      [name]: value
    }));
    
    // Validate input
    validateField(name, value);
  };

  const validateField = (name, value) => {
    const newErrors = { ...errors };
    
    // Validation rules
    switch (name) {
      case 'carat':
        if (value <= 0) {
          newErrors.carat = 'Carat must be greater than 0';
        } else if (value > 10) {
          newErrors.carat = 'Carat must be less than or equal to 10';
        } else {
          delete newErrors.carat;
        }
        break;
      case 'depth':
        if (value < 50 || value > 70) {
          newErrors.depth = 'Depth should be between 50% and 70%';
        } else {
          delete newErrors.depth;
        }
        break;
      case 'table':
        if (value < 50 || value > 70) {
          newErrors.table = 'Table should be between 50% and 70%';
        } else {
          delete newErrors.table;
        }
        break;
      default:
        break;
    }
    
    setErrors(newErrors);
  };

  const formatCurrency = (value) => {
    return new Intl.NumberFormat('en-US', {
      style: 'currency',
      currency: 'USD',
      maximumFractionDigits: 0,
    }).format(value);
  };

  return (
    <Grid container spacing={3}>
      <Grid item xs={12} md={6}>
        <Card elevation={0} sx={{ height: '100%' }}>
          <CardContent>
            <Typography variant="h5" component="h2" gutterBottom>
              Enter Diamond Details
            </Typography>
            <Typography variant="body2" color="text.secondary" sx={{ mb: 3 }}>
              Provide the characteristics of your diamond to get an estimated price range.
            </Typography>
            
            <Grid container spacing={2}>
              <Grid item xs={12}>
                <Box sx={{ display: 'flex', alignItems: 'center', mb: 1 }}>
                  <Typography>
                    Carat Weight
                  </Typography>
                  <Tooltip title={featureDescriptions.carat} placement="right">
                    <InfoIcon color="action" sx={{ ml: 1, fontSize: 18 }} />
                  </Tooltip>
                </Box>
                <TextField
                  fullWidth
                  name="carat"
                  value={diamond.carat}
                  onChange={handleChange}
                  type="number"
                  inputProps={{
                    min: 0.1,
                    max: 10,
                    step: 0.01,
                  }}
                  error={!!errors.carat}
                  helperText={errors.carat || "Enter a value between 0.1 and 10"}
                />
              </Grid>
              
              <Grid item xs={12}>
                <Box sx={{ display: 'flex', alignItems: 'center', mb: 1 }}>
                  <Typography>
                    Cut Quality
                  </Typography>
                  <Tooltip title={featureDescriptions.cut} placement="right">
                    <InfoIcon color="action" sx={{ ml: 1, fontSize: 18 }} />
                  </Tooltip>
                </Box>
                <TextField
                  select
                  fullWidth
                  name="cut"
                  value={diamond.cut}
                  onChange={handleChange}
                >
                  {diamondOptions.cut.map((option) => (
                    <MenuItem key={option} value={option}>
                      {option}
                    </MenuItem>
                  ))}
                </TextField>
              </Grid>
              
              <Grid item xs={12} sm={6}>
                <Box sx={{ display: 'flex', alignItems: 'center', mb: 1 }}>
                  <Typography>
                    Color Grade
                  </Typography>
                  <Tooltip title={featureDescriptions.color} placement="right">
                    <InfoIcon color="action" sx={{ ml: 1, fontSize: 18 }} />
                  </Tooltip>
                </Box>
                <TextField
                  select
                  fullWidth
                  name="color"
                  value={diamond.color}
                  onChange={handleChange}
                >
                  {diamondOptions.color.map((option) => (
                    <MenuItem key={option} value={option}>
                      {option}
                    </MenuItem>
                  ))}
                </TextField>
              </Grid>
              
              <Grid item xs={12} sm={6}>
                <Box sx={{ display: 'flex', alignItems: 'center', mb: 1 }}>
                  <Typography>
                    Clarity Grade
                  </Typography>
                  <Tooltip title={featureDescriptions.clarity} placement="right">
                    <InfoIcon color="action" sx={{ ml: 1, fontSize: 18 }} />
                  </Tooltip>
                </Box>
                <TextField
                  select
                  fullWidth
                  name="clarity"
                  value={diamond.clarity}
                  onChange={handleChange}
                >
                  {diamondOptions.clarity.map((option) => (
                    <MenuItem key={option} value={option}>
                      {option}
                    </MenuItem>
                  ))}
                </TextField>
              </Grid>
              
              <Grid item xs={12} sm={6}>
                <Typography>Depth Percentage (%)</Typography>
                <TextField
                  fullWidth
                  name="depth"
                  value={diamond.depth}
                  onChange={handleChange}
                  type="number"
                  InputProps={{
                    endAdornment: <InputAdornment position="end">%</InputAdornment>,
                  }}
                  inputProps={{
                    min: 50,
                    max: 70,
                    step: 0.1,
                  }}
                  error={!!errors.depth}
                  helperText={errors.depth}
                />
              </Grid>
              
              <Grid item xs={12} sm={6}>
                <Typography>Table Percentage (%)</Typography>
                <TextField
                  fullWidth
                  name="table"
                  value={diamond.table}
                  onChange={handleChange}
                  type="number"
                  InputProps={{
                    endAdornment: <InputAdornment position="end">%</InputAdornment>,
                  }}
                  inputProps={{
                    min: 50,
                    max: 70,
                    step: 0.1,
                  }}
                  error={!!errors.table}
                  helperText={errors.table}
                />
              </Grid>
            </Grid>
            
            <Box sx={{ mt: 3 }}>
              <Button 
                variant="contained" 
                color="primary" 
                fullWidth 
                onClick={calculateEstimate}
                size="large"
                disabled={Object.keys(errors).length > 0}
              >
                Calculate Estimate
              </Button>
            </Box>
          </CardContent>
        </Card>
      </Grid>
      
      <Grid item xs={12} md={6}>
        <Card elevation={0} sx={{ height: '100%' }}>
          <CardContent>
            <Typography variant="h5" component="h2" gutterBottom>
              Price Estimate
            </Typography>
            <Typography variant="body2" color="text.secondary" sx={{ mb: 3 }}>
              Based on your diamond's characteristics, here's the estimated price range.
            </Typography>
            
            {priceEstimate ? (
              <>
                <Paper 
                  elevation={0} 
                  sx={{ 
                    p: 3, 
                    textAlign: 'center', 
                    backgroundColor: 'primary.light', 
                    color: 'white',
                    mb: 3
                  }}
                >
                  <Typography variant="body1" gutterBottom>
                    Estimated Price
                  </Typography>
                  <Typography variant="h3" component="div" sx={{ fontWeight: 'bold' }}>
                    {formatCurrency(priceEstimate.prediction)}
                  </Typography>
                  <Typography variant="body2" sx={{ mt: 1 }}>
                    Estimated Range: {formatCurrency(priceEstimate.lowerBound)} - {formatCurrency(priceEstimate.upperBound)}
                  </Typography>
                </Paper>
                
                <Typography variant="subtitle1" gutterBottom>
                  Diamond Specifications
                </Typography>
                <Divider sx={{ mb: 2 }} />
                
                <Grid container spacing={2}>
                  <Grid item xs={6}>
                    <Typography variant="body2" color="text.secondary">
                      Carat Weight
                    </Typography>
                    <Typography variant="body1" gutterBottom>
                      {diamond.carat}
                    </Typography>
                  </Grid>
                  <Grid item xs={6}>
                    <Typography variant="body2" color="text.secondary">
                      Cut Quality
                    </Typography>
                    <Typography variant="body1" gutterBottom>
                      {diamond.cut}
                    </Typography>
                  </Grid>
                  <Grid item xs={6}>
                    <Typography variant="body2" color="text.secondary">
                      Color Grade
                    </Typography>
                    <Typography variant="body1" gutterBottom>
                      {diamond.color}
                    </Typography>
                  </Grid>
                  <Grid item xs={6}>
                    <Typography variant="body2" color="text.secondary">
                      Clarity Grade
                    </Typography>
                    <Typography variant="body1" gutterBottom>
                      {diamond.clarity}
                    </Typography>
                  </Grid>
                  <Grid item xs={6}>
                    <Typography variant="body2" color="text.secondary">
                      Depth Percentage
                    </Typography>
                    <Typography variant="body1" gutterBottom>
                      {diamond.depth}%
                    </Typography>
                  </Grid>
                  <Grid item xs={6}>
                    <Typography variant="body2" color="text.secondary">
                      Table Percentage
                    </Typography>
                    <Typography variant="body1" gutterBottom>
                      {diamond.table}%
                    </Typography>
                  </Grid>
                </Grid>
                
                <Box sx={{ mt: 3 }}>
                  <Typography variant="body2" color="text.secondary">
                    * This estimate is based on statistical analysis of diamond pricing data.
                    Actual market prices may vary based on additional factors such as fluorescence,
                    polish, symmetry, and market conditions.
                  </Typography>
                </Box>
              </>
            ) : (
              <Box 
                sx={{ 
                  height: '100%', 
                  display: 'flex', 
                  flexDirection: 'column', 
                  justifyContent: 'center', 
                  alignItems: 'center',
                  p: 3
                }}
              >
                <Typography variant="body1" color="text.secondary" align="center">
                  Enter diamond details and click "Calculate Estimate" to see the price prediction.
                </Typography>
              </Box>
            )}
          </CardContent>
        </Card>
      </Grid>
    </Grid>
  );
};

export default EstimatorForm; 
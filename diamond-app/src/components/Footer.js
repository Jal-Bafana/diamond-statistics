import React from 'react';
import { Box, Container, Typography, Link, Divider } from '@mui/material';

const Footer = () => {
  return (
    <Box component="footer" sx={{ py: 5, bgcolor: 'background.paper', mt: 'auto' }}>
      <Container maxWidth="lg">
        <Divider sx={{ mb: 4 }} />
        <Box sx={{ display: 'flex', flexDirection: { xs: 'column', md: 'row' }, justifyContent: 'space-between', alignItems: 'center' }}>
          <Box sx={{ mb: { xs: 2, md: 0 } }}>
            <Typography variant="body2" color="text.secondary" align="center">
              {'© '}
              {new Date().getFullYear()}
              {' Diamond Price Estimator. All rights reserved.'}
            </Typography>
          </Box>
          <Box sx={{ display: 'flex', gap: 3 }}>
            <Link href="#" color="text.secondary" underline="hover">
              Privacy Policy
            </Link>
            <Link href="#" color="text.secondary" underline="hover">
              Terms of Service
            </Link>
            <Link href="#" color="text.secondary" underline="hover">
              Contact
            </Link>
          </Box>
        </Box>
        <Typography variant="body2" color="text.secondary" align="center" sx={{ mt: 2 }}>
          Disclaimer: Price estimations are based on statistical models and serve as general guidance only. 
          Actual market prices may vary.
        </Typography>
      </Container>
    </Box>
  );
};

export default Footer; 
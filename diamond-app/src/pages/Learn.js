import React from 'react';
import { 
  Container, 
  Box, 
  Typography, 
  Grid, 
  Card, 
  CardContent, 
  Divider,
  Accordion,
  AccordionSummary,
  AccordionDetails,
  Link
} from '@mui/material';
import ExpandMoreIcon from '@mui/icons-material/ExpandMore';
import DiamondIcon from '@mui/icons-material/Diamond';
import BalanceIcon from '@mui/icons-material/Balance';
import ColorLensIcon from '@mui/icons-material/ColorLens';
import VisibilityIcon from '@mui/icons-material/Visibility';

const Learn = () => {
  const diamondFactors = [
    {
      title: "Carat Weight",
      icon: <BalanceIcon fontSize="large" color="primary" />,
      description: "Carat is the unit of measurement for the physical weight of diamonds. One carat equals 0.200 grams or 1/5 gram and is subdivided into 100 points. Carat weight is the most objective of the 4Cs – it's measured using a highly calibrated digital scale that captures weight precisely to the hundred thousandths of a carat.",
      keyPoints: [
        "Carat weight is the most significant factor in determining a diamond's price",
        "Larger diamonds are rarer than smaller diamonds, so they command much higher prices per carat",
        "Two diamonds of equal carat weight can have very different values depending on the other three Cs",
        "Common misconception: Carat refers to a diamond's size, when it actually refers to its weight"
      ]
    },
    {
      title: "Cut Quality",
      icon: <DiamondIcon fontSize="large" sx={{ color: '#4caf50' }} />,
      description: "Cut quality is how well a diamond's facets interact with light. A precisely cut diamond will appear very brilliant and fiery because it optimally interacts with light. Cut quality is the most important factor in determining a diamond's overall beauty and sparkle.",
      keyPoints: [
        "Cut quality is graded on a scale from Excellent to Poor",
        "The cut affects brightness (reflection of white light), fire (dispersion of light into colors), and scintillation (sparkle and pattern of light and dark areas)",
        "A well-cut diamond can appear larger than its actual carat weight",
        "Even if a diamond has perfect color and clarity, a poor cut can make it appear dull"
      ]
    },
    {
      title: "Color Grade",
      icon: <ColorLensIcon fontSize="large" sx={{ color: '#ff9800' }} />,
      description: "Diamond color actually refers to the absence of color. The color evaluation of normal diamonds is based on the absence of color. The GIA color scale begins with D (colorless) and continues to Z (light yellow or brown).",
      keyPoints: [
        "D-F: Colorless (highest quality and most valuable)",
        "G-J: Near Colorless (excellent value with minimal visible color)",
        "K-M: Faint Color (slight visible color, more affordable)",
        "N-Z: Very Light to Light Color (noticeable color, most affordable)",
        "Color becomes more noticeable as diamond size increases"
      ]
    },
    {
      title: "Clarity Grade",
      icon: <VisibilityIcon fontSize="large" sx={{ color: '#e91e63' }} />,
      description: "Clarity refers to the absence of inclusions and blemishes. Diamonds formed deep within the earth under extreme heat and pressure, so most have tiny imperfections. The GIA Clarity Scale includes 11 grades, from Flawless to Included (I3).",
      keyPoints: [
        "FL (Flawless): No inclusions or blemishes visible under 10x magnification",
        "IF (Internally Flawless): No inclusions visible under 10x magnification",
        "VVS1-VVS2 (Very, Very Slightly Included): Inclusions difficult for skilled grader to see under 10x",
        "VS1-VS2 (Very Slightly Included): Inclusions minor and range from difficult to somewhat easy to see",
        "SI1-SI2 (Slightly Included): Inclusions noticeable under 10x magnification",
        "I1-I3 (Included): Inclusions obvious under 10x and may affect transparency and brilliance"
      ]
    }
  ];

  const faqs = [
    {
      question: "How is a diamond's price determined?",
      answer: "A diamond's price is determined by the 4Cs (carat, cut, color, and clarity), with carat weight having the most significant impact. However, other factors such as polish, symmetry, fluorescence, and market conditions also affect pricing. Our estimator tool uses regression models based on actual market data to provide accurate price estimations."
    },
    {
      question: "Which diamond characteristic offers the best value?",
      answer: "For the best value, many experts recommend prioritizing cut quality over other characteristics. A well-cut diamond will appear more brilliant and can even appear larger than its actual carat weight. Consider diamonds in the G-J color range and VS1-SI1 clarity range for an excellent balance of quality and value."
    },
    {
      question: "Why do diamonds with the same carat weight vary in price?",
      answer: "Diamonds of equal carat weight can vary dramatically in price due to differences in the other 3Cs: cut, color, and clarity. Additionally, factors such as fluorescence, polish, symmetry, and proportions impact pricing. Two 1-carat diamonds could differ in price by thousands of dollars based on these other quality factors."
    },
    {
      question: "How accurate is the price estimate from this tool?",
      answer: "Our price estimator uses statistical models derived from real market data to provide estimates within approximately 15% of actual retail prices. However, the tool provides a general guide rather than an exact valuation. Actual prices may vary based on additional factors such as fluorescence, exact proportions, market conditions, and retailer markup."
    },
    {
      question: "What diamond characteristics should I prioritize for my budget?",
      answer: "For most budgets, prioritize cut quality first as it has the most impact on a diamond's beauty. If working with a limited budget, you can save by choosing a slightly lower color grade (G-I) and clarity grade (VS-SI) that still appear beautiful to the naked eye. Carat weight has the largest price impact, so even slightly reducing size (e.g., from 1.0 to 0.9 carat) can significantly reduce cost."
    }
  ];

  return (
    <Box sx={{ pt: 4, pb: 8 }}>
      <Container maxWidth="lg">
        <Box sx={{ mb: 5, textAlign: 'center' }}>
          <Typography variant="h3" component="h1" gutterBottom>
            Learn About Diamonds
          </Typography>
          <Typography variant="h6" color="text.secondary" sx={{ maxWidth: 800, mx: 'auto' }}>
            Understanding the 4Cs and other factors that determine a diamond's value
          </Typography>
        </Box>
        
        <Grid container spacing={4}>
          {diamondFactors.map((factor, index) => (
            <Grid item xs={12} md={6} key={index}>
              <Card elevation={0} sx={{ height: '100%', border: '1px solid', borderColor: 'divider' }}>
                <CardContent>
                  <Box sx={{ display: 'flex', alignItems: 'center', mb: 2 }}>
                    {factor.icon}
                    <Typography variant="h5" component="h2" sx={{ ml: 1 }}>
                      {factor.title}
                    </Typography>
                  </Box>
                  <Typography variant="body1" paragraph>
                    {factor.description}
                  </Typography>
                  <Typography variant="subtitle1" sx={{ mt: 2, mb: 1 }}>
                    Key Points:
                  </Typography>
                  <Box component="ul" sx={{ pl: 2 }}>
                    {factor.keyPoints.map((point, i) => (
                      <Typography component="li" variant="body2" key={i} sx={{ mb: 1 }}>
                        {point}
                      </Typography>
                    ))}
                  </Box>
                </CardContent>
              </Card>
            </Grid>
          ))}
        </Grid>
        
        <Box sx={{ mt: 6, mb: 3 }}>
          <Typography variant="h4" component="h2" gutterBottom>
            Frequently Asked Questions
          </Typography>
          <Divider sx={{ mb: 3 }} />
          
          {faqs.map((faq, index) => (
            <Accordion key={index} elevation={0} sx={{ mb: 2, border: '1px solid', borderColor: 'divider' }}>
              <AccordionSummary
                expandIcon={<ExpandMoreIcon />}
                aria-controls={`panel${index}-content`}
                id={`panel${index}-header`}
              >
                <Typography variant="subtitle1" fontWeight="500">{faq.question}</Typography>
              </AccordionSummary>
              <AccordionDetails>
                <Typography variant="body1">
                  {faq.answer}
                </Typography>
              </AccordionDetails>
            </Accordion>
          ))}
        </Box>
        
        <Box sx={{ mt: 6, textAlign: 'center' }}>
          <Typography variant="h5" gutterBottom>
            Further Learning Resources
          </Typography>
          <Typography variant="body1" paragraph>
            Explore these trusted resources to deepen your understanding of diamonds:
          </Typography>
          <Grid container spacing={2} justifyContent="center">
            <Grid item>
              <Link href="https://www.gia.edu/gem-education/diamond-grading" target="_blank" rel="noopener">
                GIA Diamond Grading Guide
              </Link>
            </Grid>
            <Grid item>
              <Link href="https://4cs.gia.edu/" target="_blank" rel="noopener">
                GIA 4Cs of Diamond Quality
              </Link>
            </Grid>
            <Grid item>
              <Link href="https://www.naturaldiamonds.com/" target="_blank" rel="noopener">
                Natural Diamond Council
              </Link>
            </Grid>
          </Grid>
        </Box>
      </Container>
    </Box>
  );
};

export default Learn; 
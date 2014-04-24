// -*- C++ -*-
//
// Package:    V0Producer
// Class:      V0Producer
// 
/**\class V0Producer V0Producer.h RecoVertex/V0Producer/interface/V0Producer.h

 Description: <one line class summary>

 Implementation:
     <Notes on implementation>
*/
//
// Original Author:  Brian Drell
//         Created:  Fri May 18 22:57:40 CEST 2007
//
//

#ifndef RECOVERTEX__V0_PRODUCER_H
#define RECOVERTEX__V0_PRODUCER_H

// system include files
#include <memory>

// user include files
#include "FWCore/Framework/interface/Frameworkfwd.h"
#include "FWCore/Framework/interface/stream/EDProducer.h"

#include "FWCore/Framework/interface/Event.h"
#include "FWCore/Framework/interface/MakerMacros.h"

#include "FWCore/ParameterSet/interface/ParameterSet.h"

#include "FWCore/Framework/interface/ESHandle.h"

#include "DataFormats/VertexReco/interface/Vertex.h"
//#include "DataFormats/V0Candidate/interface/V0Candidate.h"
#include "DataFormats/Candidate/interface/VertexCompositeCandidate.h"

#include "RecoVertex/V0Producer/interface/V0Fitter.h"

class V0Producer : public edm::stream::EDProducer<> {
public:
  explicit V0Producer(const edm::ParameterSet&);
  ~V0Producer();

private:
  virtual void produce(edm::Event&, const edm::EventSetup&) override;

  edm::ParameterSet theParams;
  V0Fitter * theVees;      
};

#endif

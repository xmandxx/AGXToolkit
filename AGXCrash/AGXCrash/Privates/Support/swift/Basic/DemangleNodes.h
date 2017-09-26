//
//  DemangleNodes.h
//  AGXCrash
//
//  Created by Char Aznable on 17/9/24.
//  Copyright © 2017年 AI-CUC-EC. All rights reserved.
//

//
//  Modify from:
//  kstenerud/KSCrash
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall remain in place
// in this source code.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

//===--- DemangleNodes.def - Demangling Tree Metaprogramming ----*- C++ -*-===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2016 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See http://swift.org/LICENSE.txt for license information
// See http://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//
//
// This file defines macros useful for macro-metaprogramming with nodes in
// the demangling tree.
//
//===----------------------------------------------------------------------===//

#ifndef AGXCrash_SWIFT_BASIC_DemangleNodes_h
#define AGXCrash_SWIFT_BASIC_DemangleNodes_h

/// NODE(ID)
///   The node's enumerator value is Node::Kind::ID.

/// CONTEXT_NODE(ID)
///   Nodes that can serve as contexts for other entities.
#ifndef CONTEXT_NODE
# define CONTEXT_NODE(ID) NODE(ID)
#endif

CONTEXT_NODE(Allocator)
NODE(Archetype)
NODE(ArchetypeRef)
NODE(ArgumentTuple)
NODE(AssociatedType)
NODE(AssociatedTypeRef)
NODE(AssociatedTypeMetadataAccessor)
NODE(AssociatedTypeWitnessTableAccessor)
NODE(AutoClosureType)
NODE(BoundGenericClass)
NODE(BoundGenericEnum)
NODE(BoundGenericStructure)
NODE(BuiltinTypeName)
NODE(CFunctionPointer)
CONTEXT_NODE(Class)
CONTEXT_NODE(Constructor)
CONTEXT_NODE(Deallocator)
NODE(DeclContext)
CONTEXT_NODE(DefaultArgumentInitializer)
NODE(DependentAssociatedTypeRef)
NODE(DependentGenericConformanceRequirement)
NODE(DependentGenericParamCount)
NODE(DependentGenericParamType)
NODE(DependentGenericSameTypeRequirement)
NODE(DependentGenericSignature)
NODE(DependentGenericType)
NODE(DependentMemberType)
NODE(DependentPseudogenericSignature)
CONTEXT_NODE(Destructor)
CONTEXT_NODE(DidSet)
NODE(Directness)
NODE(DynamicAttribute)
NODE(DirectMethodReferenceAttribute)
NODE(DynamicSelf)
CONTEXT_NODE(Enum)
NODE(ErrorType)
NODE(ExistentialMetatype)
CONTEXT_NODE(ExplicitClosure)
CONTEXT_NODE(Extension)
NODE(FieldOffset)
NODE(FullTypeMetadata)
CONTEXT_NODE(Function)
NODE(FunctionSignatureSpecialization)
NODE(FunctionSignatureSpecializationParam)
NODE(FunctionSignatureSpecializationParamKind)
NODE(FunctionSignatureSpecializationParamPayload)
NODE(FunctionType)
NODE(GenericProtocolWitnessTable)
NODE(GenericProtocolWitnessTableInstantiationFunction)
NODE(GenericSpecialization)
NODE(GenericSpecializationNotReAbstracted)
NODE(GenericSpecializationParam)
NODE(GenericTypeMetadataPattern)
CONTEXT_NODE(Getter)
NODE(Global)
CONTEXT_NODE(GlobalGetter)
NODE(Identifier)
NODE(Index)
CONTEXT_NODE(IVarInitializer)
CONTEXT_NODE(IVarDestroyer)
NODE(ImplConvention)
NODE(ImplFunctionAttribute)
NODE(ImplFunctionType)
CONTEXT_NODE(ImplicitClosure)
NODE(ImplParameter)
NODE(ImplResult)
NODE(ImplErrorResult)
NODE(InOut)
NODE(InfixOperator)
CONTEXT_NODE(Initializer)
NODE(LazyProtocolWitnessTableAccessor)
NODE(LazyProtocolWitnessTableCacheVariable)
NODE(LocalDeclName)
CONTEXT_NODE(MaterializeForSet)
NODE(Metatype)
NODE(MetatypeRepresentation)
NODE(Metaclass)
CONTEXT_NODE(Module)
CONTEXT_NODE(NativeOwningAddressor)
CONTEXT_NODE(NativeOwningMutableAddressor)
CONTEXT_NODE(NativePinningAddressor)
CONTEXT_NODE(NativePinningMutableAddressor)
NODE(NominalTypeDescriptor)
NODE(NonObjCAttribute)
NODE(NonVariadicTuple)
NODE(Number)
NODE(ObjCAttribute)
NODE(ObjCBlock)
CONTEXT_NODE(OwningAddressor)
CONTEXT_NODE(OwningMutableAddressor)
NODE(PartialApplyForwarder)
NODE(PartialApplyObjCForwarder)
NODE(PostfixOperator)
NODE(PrefixOperator)
NODE(PrivateDeclName)
CONTEXT_NODE(Protocol)
NODE(ProtocolConformance)
NODE(ProtocolDescriptor)
NODE(ProtocolList)
NODE(ProtocolWitness)
NODE(ProtocolWitnessTable)
NODE(ProtocolWitnessTableAccessor)
NODE(QualifiedArchetype)
NODE(ReabstractionThunk)
NODE(ReabstractionThunkHelper)
NODE(ReturnType)
NODE(SILBoxType)
NODE(SelfTypeRef)
CONTEXT_NODE(Setter)
NODE(SpecializationPassID)
NODE(SpecializationIsFragile)
CONTEXT_NODE(Static)
CONTEXT_NODE(Structure)
CONTEXT_NODE(Subscript)
NODE(Suffix)
NODE(ThinFunctionType)
NODE(TupleElement)
NODE(TupleElementName)
NODE(Type)
NODE(TypeAlias)
NODE(TypeList)
NODE(TypeMangling)
NODE(TypeMetadata)
NODE(TypeMetadataAccessFunction)
NODE(TypeMetadataLazyCache)
NODE(UncurriedFunctionType)
NODE(Unmanaged)
NODE(Unowned)
CONTEXT_NODE(UnsafeAddressor)
CONTEXT_NODE(UnsafeMutableAddressor)
NODE(ValueWitness)
NODE(ValueWitnessTable)
CONTEXT_NODE(Variable)
NODE(VariadicTuple)
NODE(VTableAttribute)
NODE(Weak)
CONTEXT_NODE(WillSet)
NODE(WitnessTableOffset)
NODE(ThrowsAnnotation)

#undef CONTEXT_NODE
#undef NODE

#endif /* AGXCrash_SWIFT_BASIC_DemangleNodes_h */

import { requireNativeViewManager } from 'expo-modules-core';
import * as React from 'react';
import { ViewProps } from 'react-native';

export type AiLauncherViewProps = ViewProps & {
  onProjectSelected?: (url: string) => void;
};

const NativeView: React.ComponentType<AiLauncherViewProps> = 
  requireNativeViewManager('AiLauncher');

export default function AiLauncherView(props: AiLauncherViewProps) {
  return <NativeView {...props} />;
}
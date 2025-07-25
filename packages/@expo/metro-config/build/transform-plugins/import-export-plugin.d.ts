/**
 * Copyright (c) 650 Industries (Expo). All rights reserved.
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */
import type { PluginObj } from '@babel/core';
import type { Statement, SourceLocation as BabelSourceLocation, Node as BabelNode } from '@babel/types';
import type * as BabelTypes from '@babel/types';
type Types = typeof BabelTypes;
export type Options = Readonly<{
    importDefault: string;
    importAll: string;
    resolve: boolean;
    out?: {
        isESModule: boolean;
        [key: string]: unknown;
    };
}>;
type State = {
    exportAll: {
        file: string;
        loc?: BabelSourceLocation | null;
        [key: string]: unknown;
    }[];
    exportDefault: {
        local: string;
        loc?: BabelSourceLocation | null;
        [key: string]: unknown;
    }[];
    exportNamed: {
        local: string;
        remote: string;
        loc?: BabelSourceLocation | null;
        [key: string]: unknown;
    }[];
    imports: {
        node: Statement;
    }[];
    importDefault: BabelNode;
    importAll: BabelNode;
    opts: Options;
    [key: string]: unknown;
};
export declare function importExportPlugin({ types: t }: {
    types: Types;
}): PluginObj<State>;
export {};
